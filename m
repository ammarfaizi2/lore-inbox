Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161430AbWG2DwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161430AbWG2DwO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 23:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWG2DwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 23:52:14 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:19975 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161430AbWG2DwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 23:52:14 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAFd2ykSBUw
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:1(127.0.0.1):. Processed in 0.335509 secs Process 13694)
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dsd@gentoo.org, alan@lxorguk.ukuu.org.uk,
       cw@f00f.org, greg@kroah.com, jeff@garzik.org, harmon@ksu.edu
In-Reply-To: <20060728122405.02305b69.akpm@osdl.org>
References: <1154091662.7200.9.camel@localhost.localdomain>
	 <20060728122405.02305b69.akpm@osdl.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-sYmwvKVdPei2ORtBSi7g"
Date: Sat, 29 Jul 2006 04:52:06 +0100
Message-Id: <1154145126.10955.100.camel@bastov.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 29 Jul 2006 03:52:12.0387 (UTC) FILETIME=[5F988B30:01C6B2C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sYmwvKVdPei2ORtBSi7g
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

ok,=20
Begging by answer the question, Daniel Drake, clearly, say:
"Nobody really has a full understanding of the problem and the
issues ...".=20
As I can understand, make a sort of blacklist with IDs of the
problematic VIAs, which probably will always miss some IDs, but the main
problem is in lasts lines of this email. The way how is design the list,
could be one excellent idea, inclusive for other situations on VIAs, I
don't put this in question.=20

After reviewing what I had write about this, the changelog:=20
(please correct me the English and cut some parts)=20
Well, a good new, I already have my old laptop again which have the most
problematic VIA (PCI_DEVICE_ID_VIA_82C686). At the time I bought it, I
had problematic stuffs when kernel was trying enable APIC, on this
laptop, was one Local APIC, later we had the boot option nolapic to
workaround this. So the VIA works very well without lapic enabled.
Someone give to this problem a name of "the APIC victims", happened on
VIAs, Nvidias and probably on others boards.=20
But this laptop need the quirks; nobody have put this in question,
VIA_82C686 has been always on list of the quirks. And btw, is important,
_need_ ACPI, with acpi=3Doff, 1/2 of the computer: power manager and
hot-key, don't work at all.=20
A few of the story about my laptop http://sergiomb.no-ip.org/laptop/

So, a few month ago, I bought, what I bought, one VIA of course :) with
this IDs: PCI_DEVICE_ID_VIA_82C586_1 and _2.
With this new VIA, I have exactly, the opposite problem, I found, on
this VIA with IO-APIC working well, that quirks aren't good/needed .
After, I found this interesting email http://lkml.org/lkml/2005/8/13/30
by Karsten Wiese, after, Alan Cox writes this
http://lkml.org/lkml/2005/8/16/160 (on same thread) and Karsten Wiese
end ups with the solution on http://lkml.org/lkml/2005/8/18/92, which I
want try to implement and that's it, come this idea, that may the full
understanding the problem. =20
Conclusion, I have 2 VIAs with almost same IDs (others reporters have
with exactly the same IDs) and in ones I need the quirks and in others
don't, why ? one don't have apics enabled, the other have it !?!

Thanks,=20

On Fri, 2006-07-28 at 12:24 -0700, Andrew Morton wrote:
> On Fri, 28 Jul 2006 14:01:01 +0100
> Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:
>=20
> > Hi, this patch (now for 2.6.18-rc2) is more readable.
>=20
> It has no changelog, and this sort of patch does need a lenghty one, plea=
se.
>=20
> What relationship does it have to
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/=
2.6.18-rc2-mm1/broken-out/pci-quirk_via_irq-behaviour-change.patch?
>  If it is better, why?
--=20
S=E9rgio M.B.

--=-sYmwvKVdPei2ORtBSi7g
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
SIb3DQEJBTEPFw0wNjA3MjkwMzUxNTlaMCMGCSqGSIb3DQEJBDEWBBSOtd4phFEvLFp/Wm8fAPo4
Ke+7EjANBgkqhkiG9w0BAQEFAASCAQAy7+aDUY4ovXodX3FBNy7SNWczz6SW2LtizqvOe+BhsnvN
aqAekH14xtcnYmACR6mlq9Z3Iljb7WUFlkXktL7Lt9RdhN8aNfcavGATLa8YZvVcg7FIBOdB76+P
ReqIBY4SVcGWseCkFls0tWU225Al2johf4dttUBrGP8gXHKdjGYUpfBJLSYL2kxPsdWu41AOZ3Ci
edkM9wg57PVF+9anU7zVJErGV96gucVGFLKzL3SqzjSW/35tnfexkvSonTYdUR/H6NQyDKaaUOHo
TAEM411njM17Lxz2t4xNhVycr8RPCBxvsmDGrMeucHUBKV3bhhjrOqID3iBhOXv/pYcdAAAAAAAA



--=-sYmwvKVdPei2ORtBSi7g--
