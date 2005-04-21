Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVDULGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVDULGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVDULGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 07:06:32 -0400
Received: from i254135.upc-i.chello.nl ([62.195.254.135]:25093 "EHLO
	lab.d20.nl") by vger.kernel.org with ESMTP id S261280AbVDULFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 07:05:43 -0400
Message-ID: <426788F7.7050407@d20.nl>
Date: Thu, 21 Apr 2005 13:05:27 +0200
From: Joost Remijn <remijnj@d20.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
CC: linux-kernel@vger.kernel.org
Subject: Re: strange incremental patch size [2.6.12-rc2 to 2.6.12-rc3]
References: <1617591394.20050421123259@dns.toxicfilms.tv>
In-Reply-To: <1617591394.20050421123259@dns.toxicfilms.tv>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms000907030803060807030906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000907030803060807030906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Maciej Soltysiak wrote:

>Hi,
>
>These are the sizes of rc2 and rc3 patches
>
># ls -la patch-2.6.12*
>-rw-r--r--  1 root src 18011382 Apr  4 18:50 patch-2.6.12-rc2
>-rw-r--r--  1 root src 19979854 Apr 21 02:29 patch-2.6.12-rc3
>
>Let us make an incremental patch from rc2 to rc3
>
># interdiff patch-2.6.12-rc2 patch-2.6.12-rc3 >x
>
>Let us see how big it is.
># ls -ld x
>-rw-r--r--  1 root src 37421924 Apr 21 12:28 x
>
>How come interdiff from rc2 (18MB) to rc3 (20MB) gave me
>37MB worth of patch-code ? I would expect something about
>2MB but 40MB ?
>
>  
>
The order in the patch changed a lot. The rc2 patch starts with the
changes in the CREDITS file and the rc3 patch has those starting at line
151839.  This is probably because Linus now uses different tools to
produce these. Maybe you can somehow sort the rc2 patch in the same way
as the rc3 patch (same file order) before using interdiff, that should
solve it.

Joost

>The patching with the incremental patch took very long compared
>to other rc2-rc3-type patches, that is how I noticed it.
>
>Regards,
>Maciej
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


--------------ms000907030803060807030906
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
NkVFNjAwMDAwMDAyRTFFNEFBNDE0MEVCQ0NCMj8wDQYJKoZIhvcNAQEEBQADgYEAmShkPb7Y
nqUqZYNPSwT8jrNguzW6fIBzn1zGl0jT6YkO+g8R4tEEsxQQIgIyFUKi0sdjicT2gUx3p8xR
+LOTnBfcgoCMJK0zb9whSOBwW6bWPo2zdtM16O8lIxFXFuK2GGQKEGVF2awzJaFuEAAPC9ko
2/xhWRNs7lxPPIjx7xwxggR0MIIEcAIBATCBzzCBvDELMAkGA1UEBhMCREUxEDAOBgNVBAgT
B0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2VudGVyIGZv
ciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0Q2Vu
dGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0Y2VudGVy
LmRlAg5u5gAAAALh5KpBQOvMsjAJBgUrDgMCGgUAoIICeTAYBgkqhkiG9w0BCQMxCwYJKoZI
hvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTA0MjExMTA1MjdaMCMGCSqGSIb3DQEJBDEWBBRv
RywnISoyPuOkKA+ulyyNW9v19zBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqG
SIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCB4AYJ
KwYBBAGCNxAEMYHSMIHPMIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFtYnVyZzEQMA4G
A1UEBxMHSGFtYnVyZzE6MDgGA1UEChMxVEMgVHJ1c3RDZW50ZXIgZm9yIFNlY3VyaXR5IGlu
IERhdGEgTmV0d29ya3MgR21iSDEiMCAGA1UECxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMSBD
QTEpMCcGCSqGSIb3DQEJARYaY2VydGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUCDm7mAAAAAuHk
qkFA68yyMIHiBgsqhkiG9w0BCRACCzGB0qCBzzCBvDELMAkGA1UEBhMCREUxEDAOBgNVBAgT
B0hhbWJ1cmcxEDAOBgNVBAcTB0hhbWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2VudGVyIGZv
ciBTZWN1cml0eSBpbiBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0Q2Vu
dGVyIENsYXNzIDEgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0Y2VudGVy
LmRlAg5u5gAAAALh5KpBQOvMsjANBgkqhkiG9w0BAQEFAASCAQBDyIxX9JB2rmYX3Iw/PbEe
SMonjABYdwebnPTUjCAQ/uUfIa2u7ynZOY1q2dvu4TcA4le+QMnbJZP4rR0xzfq0nEJiCWIE
45RkGG/MuK/80zb5BlcKQyOtfD3sQ423TqY+Wfz7XiAMUwW9gMRTNkLbsye5W/4nQVuQ+svF
6k9CBTejCdURGFEsFaexOhYAzbHUAYFuNMXJqwtSr1xU0qsRvR4a2/8pKmPX5o3+I1+ofdaI
Sx5lj8mVmETionaz5ZmT2jQri/U1viCHhnNv/h4jJXzhQ2mlql6Y08kP8ViFSVpDGH97h0sm
e5oKHPIhEayom3KbXVf057jdpz3k+bsdAAAAAAAA
--------------ms000907030803060807030906--
