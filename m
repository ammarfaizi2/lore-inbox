Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTKTADR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 19:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTKTADQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 19:03:16 -0500
Received: from mmp-1.gci.net ([208.138.130.80]:14800 "EHLO mmp-1.gci.net")
	by vger.kernel.org with ESMTP id S264172AbTKTADH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 19:03:07 -0500
Date: Wed, 19 Nov 2003 15:03:04 -0900
From: leif <leif@gci.net>
Subject: RE: error in Sparc64 rwlock.S
In-reply-to: <20031119143000.7815cb9d.akpm@osdl.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <014901c3aef9$ac2dac70$31828ad0@internet.gci.net>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Content-type: multipart/signed;
 boundary="----=_NextPart_000_005C_01C3AEAE.3B6F7A90"; micalg=SHA1;
 protocol="application/x-pkcs7-signature"
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_005C_01C3AEAE.3B6F7A90
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Andrew Morton replied
> 
> Ah, sorry.   This incremental patch should fix that up.
> 

Thanks.  The patch cleaned up the rwlock.S  issue.

Now I just need to hunt down the following problem. :-)

$ make
[...]
  AS      arch/sparc64/lib/xor.o
  AR      arch/sparc64/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x25ebc): In function `kallsyms_lookup':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x25ec0): In function `kallsyms_lookup':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x25f3c): In function `kallsyms_lookup':
: undefined reference to `kallsyms_names'
kernel/built-in.o(.text+0x25f40): In function `kallsyms_lookup':
: undefined reference to `kallsyms_num_syms'
kernel/built-in.o(.text+0x25f44): In function `kallsyms_lookup':
: undefined reference to `kallsyms_names'
kernel/built-in.o(.text+0x25f48): In function `kallsyms_lookup':
: undefined reference to `kallsyms_num_syms'
kernel/built-in.o(.text+0x25f54): In function `kallsyms_lookup':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x25f5c): In function `kallsyms_lookup':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x25fe8): In function `kallsyms_lookup':
: undefined reference to `kallsyms_num_syms'
kernel/built-in.o(.text+0x25ff8): In function `kallsyms_lookup':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x26048): In function `kallsyms_lookup':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x26210): In function `get_ksymbol_mod':
: undefined reference to `kallsyms_num_syms'
kernel/built-in.o(.text+0x26220): In function `get_ksymbol_mod':
: undefined reference to `kallsyms_num_syms'
kernel/built-in.o(.text+0x26270): In function `get_ksymbol_core':
: undefined reference to `kallsyms_names'
kernel/built-in.o(.text+0x2627c): In function `get_ksymbol_core':
: undefined reference to `kallsyms_names'
kernel/built-in.o(.text+0x262c0): In function `get_ksymbol_core':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x262c8): In function `get_ksymbol_core':
: undefined reference to `kallsyms_addresses'
kernel/built-in.o(.text+0x26350): In function `update_iter':
: undefined reference to `kallsyms_num_syms'
kernel/built-in.o(.text+0x26354): In function `update_iter':
: undefined reference to `kallsyms_num_syms'
make: *** [.tmp_vmlinux1] Error 1

------=_NextPart_000_005C_01C3AEAE.3B6F7A90
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
CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wMzExMjAwMDAzMDRaMCMGCSqGSIb3DQEJ
BDEWBBTL752EjKNybM7lRZ6ErzR4aPoPzzBYBgkqhkiG9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4G
CCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDAHBgUrDgMCGjAKBggqhkiG9w0C
BTCBqwYJKwYBBAGCNxAEMYGdMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlm
aWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
AwkdJTANBgkqhkiG9w0BAQEFAASBgEpXhBGSS42adhvGSPXOuc60JKgHiKp7Krads09PN/8XlEET
bHZ1OPti1JkU/iw/1eKXppxiXpwyxCLIQkp9PwxzXLu1z8rnHBAjeXcl7T4hb0f7DgPP4idgykxX
wO7bPIxxBv6JwDT9yvOTXjjZp/dKw+s1iyAs8CcuNoiKxFEFAAAAAAAA

------=_NextPart_000_005C_01C3AEAE.3B6F7A90--

