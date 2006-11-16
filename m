Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031057AbWKPBpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031057AbWKPBpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031056AbWKPBpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:45:38 -0500
Received: from smtp1.netcabo.pt ([212.113.174.28]:7850 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1031057AbWKPBph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:45:37 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAD5RW0VThFhodGdsb2JhbACBSosBAQ
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.181.10):SA:0(-1.4/5.0):. Processed in 4.092938 secs Process 2323)
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andreas Arens <ari@goron.de>
Cc: acpi devel <linux-acpi@vger.kernel.org>, tglx@linutronix.de,
       Siddha@vger.kernel.org, Suresh B <suresh.b.siddha@intel.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1163641096.3109.17.camel@monteirov>
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
	 <1163032780.19484.4.camel@monteirov> <1163034804.25019.56.camel@localhost>
	 <1163555514.3099.17.camel@monteirov>
	 <20061115193514.41C01102C011@mail.goron.de>
	 <1163641096.3109.17.camel@monteirov>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-udbwuiFlnT1tyVcfgVN/"
Date: Thu, 16 Nov 2006 01:45:24 +0000
Message-Id: <1163641524.3369.2.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 16 Nov 2006 01:45:35.0464 (UTC) FILETIME=[E8EA9680:01C70920]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-udbwuiFlnT1tyVcfgVN/
Content-Type: multipart/mixed; boundary="=-5w4M98HX8iwPT9AazA67"


--=-5w4M98HX8iwPT9AazA67
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

yap Andreas Arens send the patch just for me, I am sending it to the
maling lists.


On Thu, 2006-11-16 at 01:38 +0000, Sergio Monteiro Basto wrote:
> On Wed, 2006-11-15 at 19:40 +0100, Andreas Arens wrote:
> > as I see from the dmesg on the Fedora bugzilla, your acpi tables
> > don't provide an entry to the HPET timer.=20
>=20
> > As the VIA8237 happens to have a built-in HPET, I was able to force it
> > on using the
> > attached patch (against 2.6.18) on an X2 system with the same
> > problem, which greatly improved the system stability for me.
>=20
> But I have one Intel(R) Pentium(R) D CPU 2.8 on a VIA8237
> My latest suspect of the root of the problem of my computer is not in
> Processor but in those VIAs. As you find that "don't provide an entry to
> the HPET timer on acpi tables" it match, but how do you know that ?
> I don't send DSDT on bugzilla=20
>=20
>=20
> > The patch is hand-crafted from some older clock-tick kernel tree
> > sources I found by googling.
> >=20
> > The thing is hackish and not suitable for mainline inclusion,
> > but may be useful nontheless.
> > If you find it useful, and it helps you please let me know.
>=20
> I try your patch and it give me this differences on dmesg (file attach),
> detect a different timer.c but no improvement without notsc boot option
> and with notsc the computer got worst.
>=20
>=20
> >=20
--=20
S=E9rgio M.B.

--=-5w4M98HX8iwPT9AazA67
Content-Disposition: attachment; filename=2_6_18_via_8237_force_hpet_enable.diff
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=2_6_18_via_8237_force_hpet_enable.diff;
	charset=ISO-8859-15

LS0tIGxpbnV4LTIuNi4xOC1nZW50b28tcjIvYXJjaC94ODZfNjQva2VybmVsL3RpbWUuYy51bnBh
dGNoZWQJMjAwNi0xMS0xNSAxOToyOTowNy4wMDAwMDAwMDAgKzAxMDANCisrKyBsaW51eC0yLjYu
MTgtZ2VudG9vLXIyL2FyY2gveDg2XzY0L2tlcm5lbC90aW1lLmMJMjAwNi0xMS0xNSAxOTozMDo1
MS4wMDAwMDAwMDAgKzAxMDANCkBAIC00Miw2ICs0Miw5IEBADQogI2lmZGVmIENPTkZJR19YODZf
TE9DQUxfQVBJQw0KICNpbmNsdWRlIDxhc20vYXBpYy5oPg0KICNlbmRpZg0KKyNpZiAxDQorI2lu
Y2x1ZGUgPGxpbnV4L3BjaV9pZHMuaD4NCisjZW5kaWYNCiANCiAjaWZkZWYgQ09ORklHX0NQVV9G
UkVRDQogc3RhdGljIHZvaWQgY3B1ZnJlcV9kZWxheWVkX2dldCh2b2lkKTsNCkBAIC04MTUsNiAr
ODE4LDQ4IEBADQogc3RhdGljIGludCBocGV0X2luaXQodm9pZCkNCiB7DQogCXVuc2lnbmVkIGlu
dCBpZDsNCisjaWYgMQ0KKwl1bmlvbiBjb25mX2FkZHJlc3Mgew0KKwkJc3RydWN0IHsNCisJCQl1
OAlyZWc7DQorCQkJdTgJZnVuYzoJMzsNCisJCQl1OAlkZXY6CTU7DQorCQkJdTgJYnVzOw0KKwkJ
CXU4CXJlc2VydmVkOjc7DQorCQkJdTgJZW5hYmxlOgkxOw0KKwkJfSBiaXRzOw0KKwkJdTMyCWR3
b3JkOw0KKwl9Ow0KKwl1bmlvbiBjb25mX2FkZHJlc3MgY2EgPSB7DQorCQkuYml0cy5yZWcgPSAw
LA0KKwkJLmJpdHMuZGV2ID0gMTcsDQorCQkuYml0cy5lbmFibGUgPSAxDQorCX07DQorCXVuaW9u
IHsNCisJCXN0cnVjdCB7DQorCQkJdTggY29udHJvbDsNCisJCQl1OCBhZGRyZXNzWzNdOw0KKwkJ
fSBocGV0Ow0KKwkJdW5zaWduZWQgcmF3Ow0KKwl9IGhwZXQ7DQorCXUzMiB2ZW5kb3JfaWQsIGNv
bnRyb2w7DQorDQorCWNvbnRyb2wgPSBpbmwoMHhjZjgpOw0KKwlwcmludGsoIiVYXG4iLCBjb250
cm9sKTsNCisJb3V0bChjYS5kd29yZCwgMHhjZjgpOw0KKwl2ZW5kb3JfaWQgPSBpbmwoMHhjZmMp
Ow0KKwlpZiAodmVuZG9yX2lkID09IChQQ0lfVkVORE9SX0lEX1ZJQSArIChQQ0lfREVWSUNFX0lE
X1ZJQV84MjM3IDw8IDE2KSkpIHsNCisJCWhwZXQucmF3ID0gMHhGRUQwMDAwMDsNCisJCWhwZXQu
aHBldC5jb250cm9sID0gMHg4MDsNCisJCWNhLmJpdHMucmVnID0gMHg2ODsNCisJCW91dGwoY2Eu
ZHdvcmQsIDB4Y2Y4KTsNCisJCW91dGwoaHBldC5yYXcsIDB4Y2ZjKTsNCisJCW91dGwoY2EuZHdv
cmQsIDB4Y2Y4KTsNCisJCXZ4dGltZS5ocGV0X2FkZHJlc3MgPSAoaW5sKDB4Y2ZjKSAmIDB4RkZG
RkZGMDApOw0KKwkJcHJpbnRrKEtFUk5fV0FSTklORyAidGltZS5jOiBXQVJOSU5HOiBFbmFibGVk
IFZJQTgyMzcgSFBFVCAiDQorCQkgICAgICAgImF0ICUjbHguXG4iLCB2eHRpbWUuaHBldF9hZGRy
ZXNzKTsNCisJfQ0KKyNlbmRpZg0KIA0KIAlpZiAoIXZ4dGltZS5ocGV0X2FkZHJlc3MpDQogCQly
ZXR1cm4gLTE7DQo=


--=-5w4M98HX8iwPT9AazA67--

--=-udbwuiFlnT1tyVcfgVN/
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
SIb3DQEJBTEPFw0wNjExMTYwMTQ1MjBaMCMGCSqGSIb3DQEJBDEWBBRwcguiHFwk2Y4Nd/1Jpu+d
US4OrTANBgkqhkiG9w0BAQEFAASCAQAs9kTQeBxfwWxghCJNrjTXGKsbpL9epM6nNF80XNy7EB9x
rbgR6LdWNTIaMqa120wPNbnhi73fvC/FIsYC7xhrK43GLFae+lkGFkzajBow18gAr5ipSpCtWe5B
sr4/m+tsA8+rS+YcccgfLcauNjjAnk1sGGYq9zGYFOBReOFS++1RCBFJCm9bNfgTHpjh5lC1QDvr
4eiAYB4XXom1bCSnLR3BXuM2spOeCc/tVfC/Q1+fvvvIFaPOLTnrIzt/vSqzAlM6F/ve3T3NEWE8
H5OTjLFAxvzUxmdHI+bME8We7QV0KtGVjBlk9AyLyR8ZeYc1/oTa5WskLEiEXk4Gtoj9AAAAAAAA



--=-udbwuiFlnT1tyVcfgVN/--
