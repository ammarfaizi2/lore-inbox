Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTKYBh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 20:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKYBh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 20:37:56 -0500
Received: from daytona.gci.com ([205.140.80.57]:15114 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id S261802AbTKYBhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 20:37:47 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA315102CD204@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: RE: error in Sparc64 build:  kallsysms modules symbol resolution
Date: Mon, 24 Nov 2003 16:37:35 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
MIME-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00D2_01C3B2A9.431877C0"
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_00D2_01C3B2A9.431877C0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rusty (looks like you touched it last, does that make you the owner? :-)
et al,

I'm still receiving the following error message when compiling
for Sparc64, 2.6.0-pre10  (previously seen in -pre9)

I'm not sure if this is a dependancy error or not, since I'm still
trying to understand the build process for this portion.

It looks like scripts/kallsyms should run against .tmp_vmlinux1 to
generate symbols.S just before linking?

running kallsyms against a 2.4.22 kernel generates a file which
seems to include the correct information (that is being complained
against below)

thanks.
(Please continue to cc: me directly, as I'm not on LKML)

Leif

> $ make
> [...]
>   AS      arch/sparc64/lib/xor.o
>   AR      arch/sparc64/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x25ebc): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x25ec0): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x25f3c): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_names'
> kernel/built-in.o(.text+0x25f40): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_num_syms'
> kernel/built-in.o(.text+0x25f44): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_names'
> kernel/built-in.o(.text+0x25f48): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_num_syms'
> kernel/built-in.o(.text+0x25f54): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x25f5c): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x25fe8): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_num_syms'
> kernel/built-in.o(.text+0x25ff8): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x26048): In function `kallsyms_lookup':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x26210): In function `get_ksymbol_mod':
> : undefined reference to `kallsyms_num_syms'
> kernel/built-in.o(.text+0x26220): In function `get_ksymbol_mod':
> : undefined reference to `kallsyms_num_syms'
> kernel/built-in.o(.text+0x26270): In function `get_ksymbol_core':
> : undefined reference to `kallsyms_names'
> kernel/built-in.o(.text+0x2627c): In function `get_ksymbol_core':
> : undefined reference to `kallsyms_names'
> kernel/built-in.o(.text+0x262c0): In function `get_ksymbol_core':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x262c8): In function `get_ksymbol_core':
> : undefined reference to `kallsyms_addresses'
> kernel/built-in.o(.text+0x26350): In function `update_iter':
> : undefined reference to `kallsyms_num_syms'
> kernel/built-in.o(.text+0x26354): In function `update_iter':
> : undefined reference to `kallsyms_num_syms'
> make: *** [.tmp_vmlinux1] Error 1

------=_NextPart_000_00D2_01C3B2A9.431877C0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFuDCCAngw
ggHhoAMCAQICAwkdJTANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsT
FENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAw
MC44LjMwMB4XDTAzMDEyMTIzMjkwOVoXDTA0MDEyMTIzMjkwOVowQTEfMB0GA1UEAxMWVGhhd3Rl
IEZyZWVtYWlsIE1lbWJlcjEeMBwGCSqGSIb3DQEJARYPbHNhd3llckBnY2kuY29tMIGfMA0GCSqG
SIb3DQEBAQUAA4GNADCBiQKBgQCu1qlKy81sgP+hQsDnPs7sZfShYyGKmkdL5spm0JpheqGIboGB
IeoGP2sUX++b5TcOhbg5ZCQDd2yT75O9BN0gJLlDzNxabms5mJRBbj5LzCwucQqZG25Seo9sHk8R
mW5hCOQbnULWPEMUTG/kDNtXFZjCr0Om5OWnnTuNHqK4KQIDAQABoywwKjAaBgNVHREEEzARgQ9s
c2F3eWVyQGdjaS5jb20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCChYp5yWCZ5Mh3
h6kbzZgoeCiKM09rHvckT157nuXOj1bqm/HEsCaXDZu/MecPsaEfDixMOFP6Qwg3U67ceGL01yVP
clnNJE/api0+DU7jRBaNI09+RgwegexT6VvIqanB8riRgOtbklZX/NOymHI87yrNshq9UBONeSzc
Pj8FqTCCAzgwggKhoAMCAQICEGZFcrfMdPXPY3ZFhNAukQEwDQYJKoZIhvcNAQEEBQAwgdExCzAJ
BgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgG
A1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMg
RGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3
DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wNDA4
MjcyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQH
EwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2Vydmlj
ZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1Km1wPPrcrvfudG8w
vDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6AvbXsJHeHOmr4BgDqHxD
QlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBMMCkGA1UdEQQiMCCkHjAcMRow
GAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8ECDAGAQH/AgEAMAsGA1UdDwQEAwIB
BjANBgkqhkiG9w0BAQQFAAOBgQAxsUtHXfkBceX1U2xdedY9mMAmE2KBIqcS+CKV6BtJtyd7BDm6
/ObyJOuR+r3sDSo491BVqGz3Da1MG7wD9LXrokefbKIMWI0xQgkRbLAaadErErJAXWr5edDqLiXd
iuT82w0fnQLzWtvKPPZE6iZph39Ins6ln+eE2MliYq0FxjGCAqowggKmAgEBMIGaMIGSMQswCQYD
VQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNV
BAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNv
bmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwkdJTAJBgUrDgMCGgUAoIIBZTAYBgkqhkiG9w0B
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMzExMjUwMTM3MzRaMCMGCSqGSIb3DQEJ
BDEWBBRoB5jPlCzhXdzs4i7IRvPND+h+7zBYBgkqhkiG9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0C
BTCBqwYJKwYBBAGCNxAEMYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlm
aWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
AwkdJTANBgkqhkiG9w0BAQEFAASBgCd84hQSUGgXj8v3KwaXajsOK1kJInYqbpsKJZOgs3MApjoa
rcCRMyPtBI6IncIIvc/eOLISyu3qedS4usi8qGIigy9EMwQtBHufcd7lsU2G6nXSj+9U2Wk6jqZY
/mThHvwQCPOoRb4Y2kOrEgblqeHn8ABdihTdvk8ZmFZYgjX/AAAAAAAA

------=_NextPart_000_00D2_01C3B2A9.431877C0--

