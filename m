Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUFBKoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUFBKoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUFBKoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:44:14 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:17645 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261682AbUFBKoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:44:06 -0400
Message-ID: <40BDAD3C.3030103@giga-stream.de>
Date: Wed, 02 Jun 2004 12:34:36 +0200
From: "Ihar 'Philips' Filipau" <ifilipau@giga-stream.de>
Organization: Giga Stream
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: e1000 question
References: <40BD8E49.3070605@giga-stream.de> <20040602103027.GA74881@gaz.sfgoth.com>
In-Reply-To: <20040602103027.GA74881@gaz.sfgoth.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050103070102000008040302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050103070102000008040302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


   Thanks, Mitch!
   That explains everything.

   Went reading pci_alloc_consistent()'s RTFM.
   That is exactly what I was missing in couple of my drivers.

Mitchell Blank Jr wrote:
> Ihar 'Philips' Filipau wrote:
> 
>>   Functions e1000_clean_{t,r}x_irq are very similar: both of them are 
>>checking descriptor flag updated by nic.
>>   Host CPU, obviously, to perform this check, will cache descriptor.
>>   If, say e1000_clean_rx_irq() will be called twice in short time 
>>range, I expect that it can miss change of the flag, since old flag may 
>>still sit in host CPU cache.
> 
> 
> Please see Documentation/DMA-mapping.txt; especially the part starting
> at "There are two types of DMA mappings..."  Ring buffers are allocated
> as "consistent" DMA memory.
> 
> For most architectures this will mean that the cache hardware snoops the
> PCI bus and automatically invalidates cache lines as they are written to.
> For architectures that can't do that then Linux will mark those memory
> regions uncacheable.
> 

-- 
     Johnson's law:
            Systems resemble the organizations that create them.
--                              ___      ___
Ihar 'Philips' Filipau             \    /     Sr. Software Developer
Tel:    +49 681 959 16 0            \  /                 GIGA STREAM
Fax:    +49 681 959 16 100           \/        Konrad Zuse Strasse 7
Mobile: +49 173 39 462 49            /\           66115 Saarbruecken
email:  ifilipau@giga-stream.de     /  \                     Germany
www: http://www.giga-stream.de  ___/    \___   Switching for success


--------------ms050103070102000008040302
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJXDCC
AwwwggJ1oAMCAQICAwp5RzANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDgwNDEyMDI1OVoXDTA0MDgwMzEyMDI1OVowSTEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEmMCQGCSqGSIb3DQEJARYXaWZpbGlw
YXVAZ2lnYS1zdHJlYW0uZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCh23lX
NmvjlqAwzhanhztIary04F8dGaAt4ABMEMiNf+XD353lzpIHcHVzTH0OY4c9LtFNbt5V+XZT
JoENrCLlDDCerzYgVNEejB173dpMQW1mAoYgl5AJZArvjgojcSKWG+BMaD2ozo3NVAPMAkwD
Zhk25/WtbqN4UDf2mGljaU4/SETZKUJ+pNeeiXoz2KHlkJyZ8zubjJuR7xf5hPMpfsV+ePHI
ohDZAFlM58D6wpgbDp8DO5CL4dnqSLeW+xCv+ETDIATu8B80Cv4QifhTWIJsosEzFP6CljUE
hdBDbr3sgPTdVbTewTptD4hKodp67/2WjWsS6DMZwZl7oyTTAgMBAAGjNDAyMCIGA1UdEQQb
MBmBF2lmaWxpcGF1QGdpZ2Etc3RyZWFtLmRlMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEE
BQADgYEAXUjvmMsvEKRjvE8E2xjjymWYARwQ9fj/jbf/bpEy+fxub4It78X93RyBEazIciky
+H3ZVmjTUH+dnxzYpBrEztVIuKDsCkuF5++j+NXDsELsuOFNX+1Z/YZ4ol5rJaensb/ZwflA
byaeNV7+nl7qUgPxTanF16QDv13+EumlMdUwggMMMIICdaADAgECAgMKeUcwDQYJKoZIhvcN
AQEEBQAwgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcT
CUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2
aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMDAeFw0wMzA4
MDQxMjAyNTlaFw0wNDA4MDMxMjAyNTlaMEkxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxJjAkBgkqhkiG9w0BCQEWF2lmaWxpcGF1QGdpZ2Etc3RyZWFtLmRlMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAodt5VzZr45agMM4Wp4c7SGq8tOBfHRmgLeAATBDI
jX/lw9+d5c6SB3B1c0x9DmOHPS7RTW7eVfl2UyaBDawi5Qwwnq82IFTRHowde93aTEFtZgKG
IJeQCWQK744KI3EilhvgTGg9qM6NzVQDzAJMA2YZNuf1rW6jeFA39phpY2lOP0hE2SlCfqTX
nol6M9ih5ZCcmfM7m4ybke8X+YTzKX7FfnjxyKIQ2QBZTOfA+sKYGw6fAzuQi+HZ6ki3lvsQ
r/hEwyAE7vAfNAr+EIn4U1iCbKLBMxT+gpY1BIXQQ2697ID03VW03sE6bQ+ISqHaeu/9lo1r
EugzGcGZe6Mk0wIDAQABozQwMjAiBgNVHREEGzAZgRdpZmlsaXBhdUBnaWdhLXN0cmVhbS5k
ZTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBAF1I75jLLxCkY7xPBNsY48plmAEc
EPX4/423/26RMvn8bm+CLe/F/d0cgRGsyHIpMvh92VZo01B/nZ8c2KQaxM7VSLig7ApLhefv
o/jVw7BC7LjhTV/tWf2GeKJeayWnp7G/2cH5QG8mnjVe/p5e6lID8U2pxdekA79d/hLppTHV
MIIDODCCAqGgAwIBAgIQZkVyt8x09c9jdkWE0C6RATANBgkqhkiG9w0BAQQFADCB0TELMAkG
A1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRow
GAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2
aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSsw
KQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAwMDgzMDAw
MDAwMFoXDTA0MDgyNzIzNTk1OVowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJu
IENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRD
ZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIw
MDAuOC4zMDCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA3jMypmPHCSVFPtJueCdngcXa
iBmClw7jRCmKYzUqbXA8+tyu9+50bzC8M5B/+TRxoKNtmPHDT6Jl2w36S/HW3WGl+YXNVZo1
Gp2Sdagnrthy+boC9tewkd4c6avgGAOofENCUFGHgzzwObSbVIoTh/+zm51JZgAtCYnslGvp
oWkCAwEAAaNOMEwwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDEtMjk3
MBIGA1UdEwEB/wQIMAYBAf8CAQAwCwYDVR0PBAQDAgEGMA0GCSqGSIb3DQEBBAUAA4GBADGx
S0dd+QFx5fVTbF151j2YwCYTYoEipxL4IpXoG0m3J3sEObr85vIk65H6vewNKjj3UFWobPcN
rUwbvAP0teuiR59sogxYjTFCCRFssBpp0SsSskBdavl50OouJd2K5PzbDR+dAvNa28o89kTq
JmmHf0iezqWf54TYyWJirQXGMYID1TCCA9ECAQEwgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYD
VQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3Rl
MR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJl
ZW1haWwgUlNBIDIwMDAuOC4zMAIDCnlHMAkGBSsOAwIaBQCgggIPMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA0MDYwMjEwMzQzNlowIwYJKoZIhvcNAQkE
MRYEFJv4LpGyY/ToFFenFqRYT+Yaw6+1MFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcw
DgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEo
MIGrBgkrBgEEAYI3EAQxgZ0wgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJu
IENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRD
ZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIw
MDAuOC4zMAIDCnlHMIGtBgsqhkiG9w0BCRACCzGBnaCBmjCBkjELMAkGA1UEBhMCWkExFTAT
BgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3
dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBG
cmVlbWFpbCBSU0EgMjAwMC44LjMwAgMKeUcwDQYJKoZIhvcNAQEBBQAEggEAWdFo0RZHu1If
VOAFDP3OJ5SuKfa+zLUTiVtm03QSwobW2etA+mOir55ykHc+DAkQuz5rKEnioHctkq2H/pPl
8Aet4ZaXcYdlrIItQwdsmlsH2yyhruZMZjspjI4JZLSFDZD8NvruGLOciCuhFhqwg/3EmHUJ
hHZN7K6YllILywp+lod2p1mFrcHFe8COsIv5lqp2ZnBv86LHEqYEYik6aWBnkWzepbr5CfDP
2bMcGTjz6QnEPY0lRgIH12Q8B7irPePD7gwaWu/EqYxdU8z4uLOaadFy5pOSRbArk3Kwarjw
9fz2GBds58stav+7nzZ4klo75SM2/wB/QJyjsv2oRgAAAAAAAA==
--------------ms050103070102000008040302--
