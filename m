Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932753AbWFWBhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbWFWBhX (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 22 Jun 2006 21:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWFWBhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 21:37:22 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:37648 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161004AbWFWBhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 21:37:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AUchANvemkREgQuEUIJGgk0
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.16.51):SA:1(10.6/5.0):. Processed in 5.877051 secs Process 22720)
Subject: Re: how I know if a interrupt is ioapic_edge_type or 
	ioapic_level_type? [Was Re: [Fwd: Re: [Linux-usb-users] Fwd: Re:
	2.6.17-rc6-mm2 - USB issues]]
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: kernel@agotnes.com, akpm@osdl.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net, stern@rowland.harvard.edu,
        cw@f00f.org, vsu@altlinux.ru
In-Reply-To: <20060622162509.c36aa336.rdunlap@xenotime.net>
References: <44953B4B.9040108@agotnes.com> <4497DA3F.80302@agotnes.com>
	 <20060620044003.4287426d.akpm@osdl.org> <4499245C.8040207@agotnes.com>
	 <1150936606.2855.21.camel@localhost.portugal>
	 <20060621174754.159bb1d0.rdunlap@xenotime.net>
	 <1150938288.3221.2.camel@localhost.portugal>
	 <20060621210817.74b6b2bc.rdunlap@xenotime.net>
	 <1150977386.2859.34.camel@localhost.localdomain>
	 <20060622142902.5c8f8e67.rdunlap@xenotime.net>
	 <1151016398.3022.4.camel@localhost.portugal>
	 <20060622162509.c36aa336.rdunlap@xenotime.net>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-1VIYLsMOgxLmc/45LjOY"
Date: Fri, 23 Jun 2006 02:30:28 +0100
Message-Id: <1151026228.2858.41.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 23 Jun 2006 01:37:17.0606 (UTC) FILETIME=[8FDBFC60:01C69665]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1VIYLsMOgxLmc/45LjOY
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-22 at 16:25 -0700, Randy.Dunlap wrote:
> No idea about that.
> I think that you still didn't answer my question, or maybe I
> didn't ask it well enough.  What device are you having problems
> with? I don't mean what chipset, I mean what device that you
> touch...
>=20

I'd like to give you one answer , but  I don't have one problem with one
device, I bought (accidentally) one VIA with a Pentium dual-core, which
have a bunch of problems.=20

>=20
> > --- orig/drivers/pci/quirks.c 2006-06-21 20:25:41.000000000 +1000
> > +++ linux-2.6.17-rc6-mm2/drivers/pci/quirks.c 2006-06-21
> 20:25:08.000000000 +1000
> > @@ -662,13 +662,7 @@
> >               pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
> new_irq);
> >       }
> >  }
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C586_0, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C586_1, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C586_2, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C586_3, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C686, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C686_4, quirk_via_irq);
> > -DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA,
> PCI_DEVICE_ID_VIA_82C686_5, quirk_via_irq);
> > +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
> quirk_via_irq);
> > =20
> >  /*
> >   * VIA VT82C598 has its device ID settable and many BIOSes
> >=20
> >=20
> > But do you know or not ? how I know if dev->irq is XT-pic ?=20
>=20
> I don't see a way to know that currently.  It could be added
> somehow if it's really required.  So far I haven't seen a full
> problem description or requirement for this.=20

Well, this is based in tests along this 4 years, with my two computers.
Like Bjorn said, we don't have any specification of VIA chipsets. But I
like to try, use this quirks only if system don't have IO-APICs enabled.
Many VIA systems work like that, for example my old laptop.

For me, I know that my old laptop needs the quirks and run with
interrupts in XT-PIC, and with my new desktop, I quit sure that don't
need the quirks and system runs with interrupts in IO-APIC-edge and
IO-APIC-level.=20

Based in, what I read in this original thread
http://lkml.org/lkml/2005/8/18/92 , seems to me, that we could try this
solution, if we have a easy way to know what kind of interrupts have the
device.=20

Thanks Randy for your time,
--=20
S=E9rgio M. B.

--=-1VIYLsMOgxLmc/45LjOY
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
SIb3DQEJBTEPFw0wNjA2MjMwMTMwMjhaMCMGCSqGSIb3DQEJBDEWBBRKLbHmWDmOChlnkFxlTopK
2gSdazANBgkqhkiG9w0BAQEFAASCAQBw/yMuGse127TQmeb5NMYDd59ajTXi5ARXgQ8EEwTcOxtF
V+zzXS/0rbBVlv5s8Mdb0PLplIMOMfsjZbvYY+STzzwd5Otifd/hgXBJT1P1hAKCXHKKOOQ8OFNa
imTFi+n6e5NSLNRPUcE2DYwstJvyaa/8JcDUDUYZRw20iRoLW90lzOSe0vlnb87Ulj50J3l4fcre
bIi8yt0XxW6P+tKCW4LRB1fzFWLb60BRaNGPzIkf4b/5dsLpmbM7tQkNIBjleuW16jiEjr6uXsFF
jtZccjMHisfn/LNkoKv/P9nsar4Bcbnw5kcokGZ9EwoGlpecwQ4WBv3zyC2/0sB/s1O2AAAAAAAA



--=-1VIYLsMOgxLmc/45LjOY--
