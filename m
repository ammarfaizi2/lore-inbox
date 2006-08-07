Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750863AbWHGBy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWHGBy6 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 6 Aug 2006 21:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWHGBy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 21:54:58 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:53829 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750863AbWHGBy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 21:54:57 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAGI51kSBUYdogS8
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 4.860877 secs Process 6529)
Subject: Re: Problem: irq 217: nobody cared + backtrace
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net,
        Greg Kroah-Hartman <gregkh@suse.de>
In-Reply-To: <Pine.LNX.4.44L0.0608041309360.7905-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0608041309360.7905-100000@iolanthe.rowland.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-/W9EuY3gSbl5fipvRqcn"
Date: Mon, 07 Aug 2006 02:54:47 +0100
Message-Id: <1154915687.3151.13.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 07 Aug 2006 01:54:55.0939 (UTC) FILETIME=[7B438930:01C6B9C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/W9EuY3gSbl5fipvRqcn
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-08-04 at 13:11 -0400, Alan Stern wrote:
> On Fri, 4 Aug 2006, Sergio Monteiro Basto wrote:
>=20
> > > > I also got :
> > > > uhci_hcd 0000:00:10.1: host controller process error, something bad
> > > > happened!
> > > > uhci_hcd 0000:00:10.1: host controller halted, very bad!
> > > > uhci_hcd 0000:00:10.1: HC died; cleaning up
> > > > usb 3-2: USB disconnect, address 2
> > > >=20
> > > > > In case it happens again, here's how=20
> > > > > you can get more information.  Turn on CONFIG_USB_DEBUG and=20
> > > > > CONFIG_DEBUG_FS, and mount a debugfs filesystem somewhere (say=20
> > > > > /sys/kernel/debug).  Then after the problem occurs, save a copy o=
f=20
> > > > >=20
> > > > >         /sys/kernel/debug/uhci/0000:00:1d.1=20
> > > >=20
> > > > can you explain to me how I mount debugfs filesystem ? please
> > >=20
> > > You don't need debugfs to solve the problem shown above.
> > >=20
> > > What version of the kernel are you using?
> > >=20
> > > Alan Stern
> >=20
> > http://bugme.osdl.org/show_bug.cgi?id=3D6419#c16
> > http://bugme.osdl.org/show_bug.cgi?id=3D6419#c19
> > all the time, with 2.6.18-rc3=20
>=20
> Here is a patch which should fix the "host controller process error" =20
> problem:
>=20
> http://marc.theaimsgroup.com/?l=3Dlinux-usb-devel&m=3D115435540308759&w=
=3D2
>=20

yes! I am testing 2.6.18-rc3-git7.bz2 which have your patch, with
CONFIG_USB_DEBUG and CONFIG_DEBUG_FS on and I can googling :), it is
working. I have done a stress test with azureus and still working!=20
Tomorrow I will test the irq 201, 209 or 217 nobody care.

Many thanks Alan,
--=20
S=E9rgio M. B.

--=-/W9EuY3gSbl5fipvRqcn
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
SIb3DQEJBTEPFw0wNjA4MDcwMTU0NDNaMCMGCSqGSIb3DQEJBDEWBBTtKbEMZf0CHiufbun9mNDN
9za7xDANBgkqhkiG9w0BAQEFAASCAQCbBbArSFwinYFTufzZNLAkER2807BGF3q0PvrSC/mq8jlT
4ue4qEKXBq0kw7XtMXLJ32xcofyr0P88OzKp4wGP0tA02zQdttzMMcZMnldwJ2AL2Htmv8/v0S4n
RXedHhS0p+0CsQzvev3Guihui0JlgP4DKeaqrMGEYqYutyLJS748wBMKYzwBucVG9rYJeUEVDVr3
To9732OPaMP6Ls62Lincq0ueIRZI17RLm5BywQAolK7tMFI/2cN3H+cUMgh48zThBb6l5AbM2q3h
2c3lzQPKI9zEw1vQmgeTHIGd3ICCkGrTP1VC4VLqnMNHHZgQYE8rZtBN78NsJam7WjMDAAAAAAAA



--=-/W9EuY3gSbl5fipvRqcn--
