Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289324AbSBNBgL>; Wed, 13 Feb 2002 20:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSBNBf5>; Wed, 13 Feb 2002 20:35:57 -0500
Received: from [208.179.59.195] ([208.179.59.195]:11132 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S289317AbSBNBfe>; Wed, 13 Feb 2002 20:35:34 -0500
Message-ID: <3C6B144C.4020904@blue-labs.org>
Date: Wed, 13 Feb 2002 20:35:08 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org> <3C6B0DF8.10209@drugphish.ch>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040804000007060100000400"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040804000007060100000400
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

> o your script assumes bash as /bin/sh. Is this ok with everyone? Is
>   there noone running a Bourne shell only? printf and declare are not
>   in the standard Boune shell, IIRC. 


printf can be changed, declare can be changed. Ideas for agnostic 
functions would be appreciated.

> o the script hangs when calling loadkeys, because loadkeys without
>   arguments waits forever. A fix is to pass "loadkeys -V" as third
>   argument to pv(). 

Not acceptable, perhaps --junkoption will suffice

> o if you assume bash why don't you try to convert all of the code into
>   bash (inline functions) instead of using awk and sed like the old code
>   did? 

Because I'm not a bash guru and I'm trying to keep it as simple.

> o your script indicates that one should check for "not found/error" but
>   this never appears, it should be "error getting version, try manually" 

Fixed, thank you

> o the old script separated the loaded kernel modules with a space, the
>   new code with a '\n' 

Will be fixed, thank you

> o the old code correctly detects my "kbd" version, the new not, because
>   you use setleds which on my machine reports: "KDGKBLED: Invalid
>   argument" 

This is one of the two big problems with this script.  'kbd' and 
'console-tools'  are developed in parallel.  console-tools was forked 
from kbd when the console-tools author felt the kbd author wasn't being 
responsive or accepting updates to the kbd package.  Both kbd and 
console-tools vary significantly even within themselves as to version 
reporting.  I would like to get a large number of responses on this one 
to develop a more accurate reporting of both  kbd and console-tools.

> Why do you want to change this tool? To me it seems like an endless 
> task because people don't code according to standards. For example if 
> everyone could stick to let's say that 'progname --version' prints the 
> version, things would be a lot easier. 

Because it doesn't work as well as I want it to.  The previous writers 
of this script wrote it based on their choice of distribution and 
installed packages.  There has always been one or more strange outputs 
or breakage when I run it .  All of my software is compiled from 
original tarballs or cvs from the original author.  That means if the 
script doesn't detect it correctly, then the script is trying to detect 
a mutation of the original source, i.e. a package from a distribution.

This means that the script needs to evolve because different 
distributions are going to have differing results.

I strongly agree that "--version" woud make life pretty simple here, but 
unfortunately (i.e. kbd and console-tools).

In a side note, if anybody has a reliable way of getting pppd to 
-always- report the version number, please tell me.  To get it to fail, 
put some junk in /etc/ppp/options, i.e. a not currently existing modem 
device such as /dev/usb/acm/0.

Thank you for your feedback,
David


--------------ms040804000007060100000400
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
ARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMDA4MzAwMDAwMDBaFw0wMjA4
MjkyMzU5NTlaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYD
VQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUg
U2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwgZ8w
DQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAN4zMqZjxwklRT7SbngnZ4HF2ogZgpcO40QpimM1
Km1wPPrcrvfudG8wvDOQf/k0caCjbZjxw0+iZdsN+kvx1t1hpfmFzVWaNRqdknWoJ67Ycvm6
AvbXsJHeHOmr4BgDqHxDQlBRh4M88Dm0m1SKE4f/s5udSWYALQmJ7JRr6aFpAgMBAAGjTjBM
MCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwxLTI5NzASBgNVHRMBAf8E
CDAGAQH/AgEAMAsGA1UdDwQEAwIBBjANBgkqhkiG9w0BAQQFAAOBgQBzG28mZYv/FTRLWWKK
7US+ScfoDbuPuQ1qJipihB+4h2N0HG23zxpTkUvhzeY42e1Q9DpsNJKs5pKcbsEjAcIJp+9L
rnLdBmf1UG8uWLi2C8FQV7XsHNfvF7bViJu3ooga7TlbOX00/LaWGCVNavSdxcORL6mWuAU8
Uvzd6WIDSDGCAycwggMjAgEBMIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMU
Q2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAy
MDAwLjguMzACAwZepDAJBgUrDgMCGgUAoIIBYTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0wMjAyMTQwMTM1MDhaMCMGCSqGSIb3DQEJBDEWBBT2/If2wRg8
0M6wF5YjgVsAKVq2qjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBrQYLKoZIhvcN
AQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQ
BgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0
ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAID
Bl6kMA0GCSqGSIb3DQEBAQUABIIBAKy3j0uXg3FxW+0ShIwawEa8XtPy2s0XafgMXuScl2N2
W0IFEr5NOAQfwVe+yi2D5TtP9HEx2O9Enp/6h3c4GUUUeaKLIKW2QnR1vFiYtjajZhj/FQUF
nIfkQo7DfjhcoCXF+h+Kx59sSxkCY7lMbDFekp9BIKaMV1plnDgOWRtU0paCRarbERY9TyB5
cUHGerAJOwXHV8nMvtg4qN5offeYzzzl+rjZKbsYSWe0d5rZBfMGyX0SB+DqZQJmpZnoGWpU
7HInfV/Qg2dUU5NCNFwl4x05Q3gDxMgT6fxuPbv2id9km04zApoUPU0Gus/asZC2FiVC00KO
U5BV8LyEVGUAAAAAAAA=
--------------ms040804000007060100000400--

