Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSBOHsf>; Fri, 15 Feb 2002 02:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSBOHs0>; Fri, 15 Feb 2002 02:48:26 -0500
Received: from ip68-9-58-254.ri.ri.cox.net ([68.9.58.254]:33151 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S287516AbSBOHsM>; Fri, 15 Feb 2002 02:48:12 -0500
Message-ID: <3C6CBCE3.4090707@blue-labs.org>
Date: Fri, 15 Feb 2002 02:46:43 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ver_linux script updates
In-Reply-To: <3C6ADCAA.6080600@blue-labs.org> <3C6B0DF8.10209@drugphish.ch> <3C6B144C.4020904@blue-labs.org> <3C6B20FD.1070601@drugphish.ch> <3C6B6C01.8000403@blue-labs.org> <3C6C718C.8050402@drugphish.ch>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms060104000800030004090802"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms060104000800030004090802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

> Well, you added it again in version 1.4 of your script. I removed it. 
> But I reckon you should write it in bash, can safe you some lines :) 


This begs the question from the powers that be, what is the opinion of 
using sh vis bash?  'printf' is available as a bash builtin and as a 
sh-util file which should be found on most distributions; enough for me 
to say that lacking both bash and the sh-util printf should be a rare 
occurance.

>> What is the full output of your loadkeys program with --junkoption?  
>> I avoided using combinations of programs and chose to concentrate on 
>> implementing a one program only solution which was common through the 
>> script.
>
>
> Et voilà, feel free to vomit:
>
> ratz@laphish:~ > grep declare ver_linux.*
> ver_linux.txt:      declare -i count
> ratz@laphish:~ > loadkeys --junkoption
> loadkeys: unrecognized option `--junkoption'
> loadkeys version 1.04
>
> Usage: loadkeys [option...] [mapfile...]
>
> valid options are:
>
>     -c --clearcompose clear kernel compose table
>     -d --default      load "defkeymap.map"
>     -h --help      display this help text
>     -m --mktable      output a "defkeymap.c" to stdout
>     -s --clearstrings clear kernel string table
>     -u --unicode      implicit conversion to Unicode
>     -v --verbose      report the changes
> ratz@laphish:~ > 

Thanks.  This version of loadkeys comes from the kbd package (btw, 1.06 
was released a while ago).  The place where I'm using loadkeys is in the 
console-tools package, if you can find a tool that exists more commonly 
in console tools, great.  However I'm wondering if I really need to make 
the distinction in the script.  Is it really important to show the 
version of both kbd and console-tools? I'm beginning to think that 
avoiding this ugly mess would be nice, just print out a given version 
number from a series of a|b|c|d trials and whatever comes out first 
should be suitable.

>> loadkeys is part of the kbd/console-tools mess.  It can report a 
>> version, not report a version, use --version or -V depending on what 
>> package or date in history your package comes from.
>
>
> This is an information which you exactly don't have.

See above.

>>> This is so gross you could as well do a strings on all those broken 
>>> binaries and maintain a table of offsets where to find the version 
>>> string. 
>>
>>  
>> Unfortunately this would evolve into a big pile of versions and 
>> offsets that nobody would want to touch with a 10' pole.
>
>
> I was more making a joke on this one ... 

I kind of figured that :)

>> One doesn't, it's a generic list that makes some assumptions.  To 
>> this end, I've decided to add some /proc checking before searching 
>> for certain tool versions.
>
>
> Ok, hope /proc-fs doesn't change semantics. 

In this situation, it'll be a matter of keeping up with the Joneses. 
 There is an incredible amount of stubborness to changing already 
existing files in /proc so I'm not going to give this any thought.

>> One of the most visible points in history is pppd, for a long while 
>> it seemed like the most frequently recurring bug post was why pppd 
>> didn't work. The version the bug reporter had was less than required.
>
>
> I haven't seen one in a year or so but I assume you know how Linux 
> kernel development history goes, so it's you call. I saw that you made 
> some /proc check for ppp. This is very acceptable then. 

Not that I'm an old fart, but I discovered Linux back in the pre 1.0 
days. Linux was my roommate's get rich quick ISP idea when 56K dedicated 
lines were the bomb.

> You seemed to have solved it in a way. One little invariant to fix 
> remains though. Think what happens with your script, when one doesn't 
> have proc-fs support ;) 

Heh.. I could make work arounds, but that adds complexity which tends to 
add breakage.   Perhaps someone can suggest an ingenious method for 
figuring out what is/isn't supported by the kernel

Changes applied.

David


--------------ms060104000800030004090802
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
MBwGCSqGSIb3DQEJBTEPFw0wMjAyMTUwNzQ2NDNaMCMGCSqGSIb3DQEJBDEWBBSVOMmV5+5m
9g47xU3hlFlUPMrI+jBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMC
AgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBrQYLKoZIhvcN
AQkQAgsxgZ2ggZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQ
BgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0
ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAID
Bl6kMA0GCSqGSIb3DQEBAQUABIIBAKAQT7oIU92LPLHsV30itNEMlTlrhnEPdukRLfAANzht
H4P9JF4IdxjtEgOnoL8V3YdWIINePLxHzmR+4DlF8x1pCDTqPeIS4hp2nGXcEV6A8JQOtrU2
eFqk/8vQdmFBEAE3dav9cJ+S62HgWXK1Bzciwkdz4QsQmydVyUZn2gA/PawVJ0mPWQf9TTjl
QiZwYdHC9wZIHTrQ79dJsbkAoAAvD88lo9eMm0Q3yRdYEKohbdveU8o8d0DvuNpmUsJhdtA3
6sF1D0uaycruNHyARHZ4dbgy0vXClOJcQ3aWrrpHi98KiACHeBpL22D4hWrL+X2A+nFID5PE
bb9c+UhzBnwAAAAAAAA=
--------------ms060104000800030004090802--

