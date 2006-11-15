Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966436AbWKOB6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966436AbWKOB6u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 20:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966624AbWKOB6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 20:58:49 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:19785 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S966436AbWKOB6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 20:58:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FABUCWkVThFhodGdsb2JhbACBSw
X-IronPort-AV: i="4.09,422,1157324400"; 
   d="p7s'?scan'208"; a="126717578:sNHT26067150"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.138):SA:0(-1.4/5.0):. Processed in 4.504898 secs Process 21170)
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: john stultz <johnstul@us.ibm.com>
Cc: tglx@linutronix.de, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1163034804.25019.56.camel@localhost>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <20061030184155.A3790@unix-os.sc.intel.com>
	 <1162345608.2961.7.camel@localhost.portugal>
	 <20061031184411.E3790@unix-os.sc.intel.com>
	 <1162945339.4455.12.camel@monteirov>
	 <1163015628.8335.52.camel@localhost.localdomain>
	 <1163032780.19484.4.camel@monteirov>  <1163034804.25019.56.camel@localhost>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-XOdrR+YlyK3bRN/x8huz"
Date: Wed, 15 Nov 2006 01:51:54 +0000
Message-Id: <1163555514.3099.17.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 15 Nov 2006 01:58:46.0813 (UTC) FILETIME=[962F1CD0:01C70859]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XOdrR+YlyK3bRN/x8huz
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 at 17:13 -0800, john stultz wrote:
> On Thu, 2006-11-09 at 00:39 +0000, Sergio Monteiro Basto wrote:
> > On Wed, 2006-11-08 at 20:53 +0100, Thomas Gleixner wrote:
> > > This one is a lock dependency problem, which is fixed in -rc5-mm1
> >=20
> > yes, oops fixed w/ and w/o notsc option.
> > Other question, hrtimer in 2.6.18 found acpi_pm clocksource and use it.
> > With 2.6.19-rcx can't get acpi_pm clocksource even trying force at boot
> > kernel with clocksource=3Dacpi_pm, any idea ?
> > because with this clocksource my lost ticket disappears=20
>=20
> Looking at the dmesg in the bugzilla:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D6419
>=20
> I noticed you're using x86_64.=20

yes, I _just_ use x86_64 never test it on i386.

> x86_64 doesn't yet support clocksource
> overrides in mainline,

petty , can I have a experimental patch to test it?

>  as it is not converted to GENERIC_TIME. (Probably
> printing out such a warning if an override is used would be nice. I'll
> try to get to that soon.)
>=20
> Now, the code to convert x86_64 is in tglx's hrtimer patch set, so I'm
> glad to hear its working for you, however I'm not sure if it really is
> solving the issue or just hiding it (as lost ticks won't affect
> timekeeping when you use continuous clocksources and GENERIC_TIME).

Well, the only kernel where I can work (yes I use computer to work) is
2.6.18 + dyntick. I think don't hid neither solve the issue, is just use
other resource (clocksource) that works better ! .

>=20
> To use the ACPI PM w/ a 2.6.19-rcX kernel, use "notsc", and you'll see
> the line:
>  time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
>=20
> Using the "notsc" option, do you continue to see lost tick messages
> after bootup?

I just test 2.6.19-RC5-mm2 and still very unstable even with notsc.=20
And after bootup, yes appears some lost tick messages.
Just trying rebuild other kernel and use command yum to update others
things, at same time, have lock up my computer.
So I back to kernel 2.6.18 + dyntick =20

Thanks,

>=20
> thanks
> -john
>=20
>=20
--=20
S=E9rgio M.B.

--=-XOdrR+YlyK3bRN/x8huz
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjExMTUwMTUxNDlaMCMGCSqGSIb3DQEJBDEWBBTK52G2/ou3535bXGvX1ru9
Q9mYNjANBgkqhkiG9w0BAQEFAASCAQCE6KhC9kMWIQczq6LNrglQ0HjnOO01t28EvOb8SadzdyfR
TqVzx4wWBl0ajcW5xVENR88uDS2Wr4vHVqJ+jurixzu+G6a6aooSySpYZms11aVt0U1e4d7vk/ue
W0dmUPcBEpDJa0Jipvu5zEU5xfeauGUoPRooSsSKvymCa6f88oulPVn1i8s6+DsByo+GL5ilOPad
9nwpdCsmMk7pZDL+IQgE1OxBl6CfYoYeVlcLnpG/XvAUi/7BB2Ew71djRKpb7Wqwmm87Si8wC/dz
aLALHGSB+FUNYtRll4/T+j/0EWlSYtj+0oZZtbQeaGXJliK4q41hot+HNW3q858Sz0KhAAAAAAAA



--=-XOdrR+YlyK3bRN/x8huz--
