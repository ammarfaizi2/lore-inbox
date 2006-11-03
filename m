Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752864AbWKCAVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbWKCAVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 19:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752868AbWKCAVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 19:21:38 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:41280 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1752864AbWKCAVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 19:21:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAANIYSkVThFhofmdsb2JhbACMSQEB
X-IronPort-AV: i="4.09,382,1157324400"; 
   d="p7s'?scan'208"; a="118614533:sNHT40630644"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.125):SA:0(-1.3/5.0):. Processed in 3.448958 secs Process 9408)
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Stephen.Clark@seclark.us
Cc: Dave Jones <davej@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <454A2D54.4060901@seclark.us>
References: <4548DDF4.2030903@seclark.us>
	 <20061101201218.GA4899@martell.zuzino.mipt.ru>
	 <45490EFE.1060608@seclark.us> <20061101235546.GB10577@redhat.com>
	 <4549450F.3080207@seclark.us>  <20061102030353.GA2797@redhat.com>
	 <1162441409.7677.23.camel@monteirov>  <454A0352.8010207@seclark.us>
	 <1162478860.12936.6.camel@localhost.localdomain>
	 <454A2D54.4060901@seclark.us>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-1n+z1fOXV4MWoOjaz8Wt"
Date: Fri, 03 Nov 2006 00:21:23 +0000
Message-Id: <1162513283.2616.19.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 03 Nov 2006 00:21:35.0283 (UTC) FILETIME=[055D4030:01C6FEDE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1n+z1fOXV4MWoOjaz8Wt
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-02 at 12:39 -0500, Stephen Clark wrote:
> Sergio Monteiro Basto wrote:
>=20
> >On Thu, 2006-11-02 at 09:40 -0500, Stephen Clark wrote:
> > =20
> >
> >>Sergio Monteiro Basto wrote:
> >>
> >>   =20
> >>
> >>>On Wed, 2006-11-01 at 22:03 -0500, Dave Jones wrote:
> >>>=20
> >>>
> >>>     =20
> >>>
> >>>>On Wed, Nov 01, 2006 at 08:08:31PM -0500, Stephen Clark wrote:
> >>>>
> >>>>       =20
> >>>>
> >>>>>booting without lapic allowed it to boot but now I get
> >>>>>...
> >>>>>Local APIC disabled by BIOS -- you can enable it with "lapic"
> >>>>>...
> >>>>>Local APIC not detected. Using dummy APIC emulation.
> >>>>>  which means more processor overhead - right?
> >>>>>
> >>>>>also cpuspeed doesn't work anymore - I don't have a cpufreq dir
> >>>>>         =20
> >>>>>
> >>>>The Duron had powernow ?
> >>>>  =20
> >>>>
> >>>>       =20
> >>>>
> >>>This story of trying enable lapic when BIOS don't, has been triggered =
on
> >>>kernel2.6.18, but in my opinion is not a bug if lapic on those compute=
rs
> >>>don't work.
> >>>
> >>>If you boot without enable lapic, you will see cat /proc/interrupts wi=
th
> >>>interrupts in XT-PIC.
> >>>if you try enable lapic, somehow IRQ routing should change=20
> >>>and if /proc/interrupts still the same, with IRQs in XT-PIC.
> >>>I think, lapic still not enabled and the most you can get it's problem=
s.
> >>>Unless you know that lapic works (it is programmed and BIOS wrongly
> >>>disable it), you shouldn't try enable lapic because it is probable tha=
t
> >>>just give problems, to you.=20
> >>>Historically: In 2002/3 was a very common bug, when kernel was compile=
d
> >>>to support lapic and try enable lapic (even when BIOS don't) and
> >>>computer hangs on boot.=20
> >>>=20
> >>>
> >>>     =20
> >>>
> >>Loading the correct kernel arch 686 - fixes my powernow problems - this=
=20
> >>is a mobile duron.
> >>
> >>Booting with lapic worked fine on  fc5 kernel-2.6.18-2200 but it causes=
=20
> >>fc6 kernel-2.6.18-2798
> >>to hang.
> >>   =20
> >>
> >
> >With lapic boot option enabled, have you a different /proc/interrupts ?=20
> >have you lapic working ?=20
> >
> >
> >
> > =20
> >
> No interrupt assignments are the same -=20

So , you shouldn't try eneble lapic=20

> but what about the hi-res timer=20
> the lapic is
> supposed to have and linux is suppose to use?
>=20

Local APIC and IO-APIC works on Linux many time ago, before hi-res
timer.=20

The problem is that lapic are in computer but aren't programmed or isn't
suppose to work, this is not clear, why this lapics don't work.

what we know is that BIOS says that computer don't have lapic, so it it
a mistake try enable something that don't work , I think.

I had a Compaq Presario laptop with this problem, so I know this because
I pass throw it. you have one Laptop HP which could be a similar issue.


Regards,


> Steve
>=20
--=20
S=E9rgio M.B.

--=-1n+z1fOXV4MWoOjaz8Wt
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
SIb3DQEJBTEPFw0wNjExMDMwMDIxMjBaMCMGCSqGSIb3DQEJBDEWBBToPOnUWRD8fkN9rfcQk26/
DcYU3zANBgkqhkiG9w0BAQEFAASCAQAtzeDoWip/I3CP7++vO3yHHphxbggKbDhNUVOLgfrsnTd1
vkMef/NRDT7sEh08xeO/0eheRlvwBfxgE6XhI8+nZgRJLZrmBIN8+GExIEusijH2gqoBaWQRr2Xb
PL1Pj34btgq8TW8cn3j6HwwvmiH47xE/gV7IkeLTSdo5YrEHzM6HUqkHwmgtfY9PP0C8+fqGm+X1
9tpiummfSbXGaOqP1uUQsnKQ3R1b0uMeiBYAONcHcqb0lTw1GLuoptbB2jyReWTZs4tVrwMtx5Si
VMwgLd3GLEOU0WGWzSd2F5FNG6QHsJ7GwSSm9t2xe+FaTRcJgxt/YcbSsMlKCmzyLJxXAAAAAAAA



--=-1n+z1fOXV4MWoOjaz8Wt--
