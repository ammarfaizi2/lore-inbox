Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTHBMfL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHBMfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:35:11 -0400
Received: from brmea-mail-2.Sun.COM ([192.18.98.43]:6068 "EHLO
	brmea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262321AbTHBMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:35:00 -0400
Message-ID: <3F2BAFE8.3090001@sun.com>
Date: Sat, 02 Aug 2003 13:34:48 +0100
From: Calum Mackay <calum.mackay@sun.com>
Organization: Sun Microsystems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030802 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Calum Mackay <calum.mackay@sun.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Calum Mackay <calum.mackay@cdmnet.org>, marcelo@conectiva.com.br,
       mitch.dsouza@sun.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  2.4: export the symbol "mmu_cr4_features" for XFree86
 DRM kernel drivers
References: <3F2A62A2.mailx3G211O2B4@cdmnet.org> <20030801141445.A8186@infradead.org> <3F2BA671.4070800@sun.com>
In-Reply-To: <3F2BA671.4070800@sun.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060908070601060609020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060908070601060609020705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Calum Mackay wrote:
> The radeon kernel driver source includes (via drm_memory.h) 
> linux/vmalloc.h, iff VMAP_4_ARGS is defined. The latter includes (on 
> i386) asm/asm-i386/pgtable.h, which includes asm/asm-i386/processor.h.
> 
> processor.h defines some inline functions [set_in_cr4() & 
> clear_in_cr4()] which reference mmu_cr4_features.

Sadly, this isn't the full story, since the radeon code doesn't 
reference *_in_cr4.

The radeon code calls io/agp remap functions - again only ifdef 
VMAP_4_ARGS - which do however call __flush_tlb_all(). This manipulates 
the PGE bit via mmu_cr4_features.

apols for the spam...

cheers,
Calum.

--------------ms060908070601060609020705
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJUDCC
AwYwggJvoAMCAQICAwmkMDANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDQwMjExNTQyNFoXDTA0MDQwMTExNTQyNFowRjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEjMCEGCSqGSIb3DQEJARYUY2FsdW0u
bWFja2F5QHN1bi5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2Pf0g8+xc
uFdqY2GawPSrCRij/s6c6hXDl4/swD3Xzqqqz6BvbL6iSyXX6i3uBPEZwzNlocajDr+30kJz
8ckD3EuwcPH9i8akKoniEXX5OzHN9T0OmefgkBHU7//MTUHagTMxu9+6PTVcT1DJN702uCwl
7WMPLjpo602F4ZUk6+Z5qjrbf/C85mbIfhu2vKn5L+y9J4rLritUjoV1S3jVov7EwA+9zFiA
Yea5HQNvdiyBHOEfGdH1xfEkoDmX4/t5M37VuaYz821XLzzKovRgYhkj1aTH06WSQSBQK/9w
IeP+lW5o6H/RR2COhYr3aceBIzBy2wnAkCSsFrIKZvUjAgMBAAGjMTAvMB8GA1UdEQQYMBaB
FGNhbHVtLm1hY2theUBzdW4uY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEA
cHCSGCSGqfAWLM54EZHAWeTslfWXstPdvzXXgf4gxKo9W3FQURit5lACxezuaIUpigIoP2K8
HVahG2KJdnB7CsvrzBFTiDlZzPkXNDbTwDmM4OKfqJcEnRl/1A2bszFn8ckQ14tcbr+tEp1R
0O3SVidOOntLrJKaY5fclHBgoeQwggMGMIICb6ADAgECAgMJpDAwDQYJKoZIhvcNAQEEBQAw
gZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
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
AgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGrBgkrBgEEAYI3
EAQxgZ0wgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNV
BAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBT
ZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAIDCaQw
MIGtBgsqhkiG9w0BCRACCzGBnaCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rl
cm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0Eg
MjAwMC44LjMwAgMJpDAwDQYJKoZIhvcNAQEBBQAEggEAGLF4aOquNQW1cQ9CqstoOsYbUtRL
DmAZ74sv5iCAiIhml87cySnPTGD4GjJ2hLVyaU3Nn7TsT4Xjf08Adipgrt/6q5iKeucdACGH
2qagrdyijLocX2iO3W+Ot2TkrY8TVonvdvv5D7+CCb65uqfJRLuvQqrUCoRy4ejkIKOtJP8L
cyLXX/PQRVU6DclJJ7BJfQifaadMsyjGPaOJX+bol50zjbi3CUm/dYLexDnHsZEu8ysCuYPO
tP62wJx6Qs5YlpEzmV0N8qNykG+rHaDXeIzp/HxJUj0z92J6jMRwGg6ncoWER/ZP7SN5Q2Bo
1bnItU/RJBJTn8lwfnclNYJGOgAAAAAAAA==
--------------ms060908070601060609020705--

