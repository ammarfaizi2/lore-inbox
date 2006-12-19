Return-Path: <linux-kernel-owner+w=401wt.eu-S1752625AbWLSGIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbWLSGIt (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWLSGIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:08:48 -0500
Received: from smtp2.netcabo.pt ([212.113.174.29]:34682 "EHLO
	exch01smtp09.hdi.tvcabo" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752625AbWLSGIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:08:47 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAEIRh0VThFhodGdsb2JhbACNcwE
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.20):SA:0(0.5/5.0):. Processed in 3.667226 secs Process 25615)
Subject: Re: RFC: PCI quirks update for 2.6.16
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Daniel Drake <dsd@gentoo.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jean Delvare <khali@linux-fr.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@redhat.com>
In-Reply-To: <20061210234733.GH10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
	 <1165723779.334.3.camel@localhost.localdomain>
	 <20061210160053.GD10351@stusta.de> <457C345D.8030305@gentoo.org>
	 <20061210223351.GA22878@tuatara.stupidest.org>
	 <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org>
	 <20061210234733.GH10351@stusta.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-0l9tvKip3eFppP54+Uwe"
Date: Tue, 19 Dec 2006 06:08:41 +0000
Message-Id: <1166508521.3800.40.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
X-OriginalArrivalTime: 19 Dec 2006 06:08:46.0004 (UTC) FILETIME=[24718740:01C72334]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0l9tvKip3eFppP54+Uwe
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-12-11 at 00:47 +0100, Adrian Bunk wrote:
> So we have the following situation:
> - 2.6.16    - 2.6.16.16 : problems for Chris
>                           (and possibly many other people)
> - 2.6.16.17 - 2.6.16.35 : problems for many other people
>                           (I remember 4-5 bug reports in the kernel
>                            Bugzilla alone)
>=20
> The fix in 2.6.19 was considered suboptimal, and Alan's patch for
> fixing=20
> this whole issue more properly is currently not even in your tree. =20

Right,
Those 4-5 bug reports should test Alan's patch.
All the problem is detected the correct devices that should be quirked.
In 2.6.16, all ( PCI_VENDOR_ID_VIA, PCI_ANY_ID), in 2.6.16.17 just some.
Still questionable if this quirks is for on-board VIA when interrupts
are in PIC mode, or for all interrupts modes (historically before the
patch to be for IO-APIC and PIC mode, was just for PIC mode, but in that
time IO-APIC wasn't common on PC) .
So with Alan's patch the question is:if a device need to be quirked and
don't.=20
Those 4-5 reports will answer the question, they needs VIA quirks and we
want know is the patch do the right job.=20
My laptop that need the quirks and I can test it is not available right
now and I am too busy to test on it, sorry.

Thanks,
--=20
S=E9rgio M.B.

--=-0l9tvKip3eFppP54+Uwe
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
SIb3DQEJBTEPFw0wNjEyMTkwNjA4MzdaMCMGCSqGSIb3DQEJBDEWBBSzStMlVboPA0HsVj+ViFcQ
feAq6TANBgkqhkiG9w0BAQEFAASCAQBIT1uUQswTuIrarzI0DXFiv/jTaUwAPma9bGG811rCMwhj
8JK5oxFYsNJDH9zYs3wTDcV4dAlpsA3QsB6Qlpmea3SZ6RXXQKPk1vxLbXL3gxAeNXzQq2d5kR7Z
hBOQR/iAklgrUf7daIUhPKodcrGF5wincjwNaXjlUtDqPTyXXmshzUoBJ6p48a36x8/rVNM0iLhU
NVh+KA+C93lJm1KTpxloEG8I/HYinvako0KRxOD5SnZ4kLbOGM91lBvfyh/z1JGjgdIobZirXXxm
14mbaV9P0dISohuGdKikv5RxgSEOzu6wNGb8k6UE/RgFaZp7EvYvcJzfoumHFo+sLSwwAAAAAAAA



--=-0l9tvKip3eFppP54+Uwe--
