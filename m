Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVJ0Obx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVJ0Obx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 10:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVJ0Obx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 10:31:53 -0400
Received: from smtp04.wanadoo.nl ([194.134.35.144]:32518 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S1750814AbVJ0Obw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 10:31:52 -0400
Message-ID: <4360E4D5.9070505@lazarenko.net>
Date: Thu, 27 Oct 2005 16:31:49 +0200
From: Vladimir Lazarenko <vlad@lazarenko.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eugene Crosser <crosser@rol.ru>
Cc: Jens Axboe <axboe@suse.de>, Brett Russ <russb@emc.com>,
       linux-ide@vger.kernel.org, multiman@rol.ru,
       linux-kernel@vger.kernel.org
Subject: Re: Status of Marvell SATA driver (was Re: Trying latest sata_mv
 - and getting freeze)
References: <435F8AFF.3030404@rol.ru> <435F9737.3050409@emc.com> <435FA5D8.2090406@rol.ru> <20051027111650.GO4774@suse.de> <4360E3A0.70501@rol.ru>
In-Reply-To: <4360E3A0.70501@rol.ru>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020902090503050106060304"
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "dinosaur.lazarenko.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >>>>>My hardware is SMP Supermicro with 6 disks on
	>>>>>Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
	>>>>>and the sata_mv.c is version 0.25 dated 22 Oct 2005 >>>>> >>>>>The
	thing works with "old" mvsata340 driver, but the "new" kernel with
	>>>>>your driver freezes when it starts to probe disks. Even Magic SysRq
	>>>>>does not work. The last lines I see on screen are like this: >>>>>
	>>>>>sata_mv version 0.25 >>>>>ACPI: PCI Interrupt 0000:02:03.0[A] ->
	GSI 56 (level, low) -> IRQ 185 >>>>>sata_mv(0000:02:03.0) 32 slots 8
	ports unknown mode IRQ via MSI >>>>>ata1: SATA max UDMA/133 cmd 0x0 ctl
	0xF8C22120 bmdma 0x0 irq 185 >>>>>ata2: .... <same things> 0xF8C24120
	... >>>>>... >>>>>ata8: .... <same thing> 0xF8C38120 ... >>>>>ATA:
	abnormal status 0x80 on port 0xF8C2211C >>>>>... <five more lines
	identical to the above> >>>>>ata1: dev 0 ATA-7, max UDMA/133, 781422768
	sectors: LBA48 >>>>> >>>>>- and at this point it freezes hard. >>>>>Any
	suggestions for me? Any information I can collect to help
	>>>>>troubleshooting? >>> >>>[...] >>> >>> >>>>In the meantime, try
	turning off SMP and seeing if that makes a >>>>difference. There still
	might be a problem with the spinlocks and if so >>>>it should go away in
	uniprocessor mode. >>> >>>'nosmp' makes no difference. >> >> >>Booting
	with nosmp isn't enough, you need to compile the kernel with
	>>CONFIG_SMP turned off. Otherwise the spinlocks will still be used and
	>>could cause a hard hang. > > > Yeah, that was it! It boots with the
	kernel compiled for UP. > (did not yet have a chance to check how it
	works). > Any chance that somebody competent would fix the driver for
	SMP? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020902090503050106060304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>>>>>My hardware is SMP Supermicro with 6 disks on
>>>>>Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
>>>>>and the sata_mv.c is version 0.25 dated 22 Oct 2005
>>>>>
>>>>>The thing works with "old" mvsata340 driver, but the "new" kernel with
>>>>>your driver freezes when it starts to probe disks.  Even Magic SysRq
>>>>>does not work.  The last lines I see on screen are like this:
>>>>>
>>>>>sata_mv version 0.25
>>>>>ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
>>>>>sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
>>>>>ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
>>>>>ata2: .... <same things>            0xF8C24120 ...
>>>>>...
>>>>>ata8: .... <same thing>             0xF8C38120 ...
>>>>>ATA: abnormal status 0x80 on port 0xF8C2211C
>>>>>... <five more lines identical to the above>
>>>>>ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
>>>>>
>>>>>- and at this point it freezes hard.
>>>>>Any suggestions for me?  Any information I can collect to help
>>>>>troubleshooting?
>>>
>>>[...]
>>>
>>>
>>>>In the meantime, try turning off SMP and seeing if that makes a
>>>>difference.  There still might be a problem with the spinlocks and if so
>>>>it should go away in uniprocessor mode.
>>>
>>>'nosmp' makes no difference.
>>
>>
>>Booting with nosmp isn't enough, you need to compile the kernel with
>>CONFIG_SMP turned off. Otherwise the spinlocks will still be used and
>>could cause a hard hang.
> 
> 
> Yeah, that was it!  It boots with the kernel compiled for UP.
> (did not yet have a chance to check how it works).
> Any chance that somebody competent would fix the driver for SMP?

Umm, that sounds freakingly familiar to what I just had with sata_nv... 
Try "noapic" in smp mode, will that help?

And just in case, did you try 2.6.14-rc5? That was the kernel that fixed 
my similar problem "out-of-the-box".

Regards,
Vladimir

--------------ms020902090503050106060304
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ2zCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggNIMIICsaADAgECAgMPl0owDQYJKoZIhvcNAQEE
BQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1
MTAwNDE4Mjk1NloXDTA2MTAwNDE4Mjk1NlowgZgxEjAQBgNVBAQTCUxhemFyZW5rbzERMA8G
A1UEKhMIVmxhZGltaXIxGzAZBgNVBAMTElZsYWRpbWlyIExhemFyZW5rbzEhMB8GCSqGSIb3
DQEJARYSdmxhZEBsYXphcmVua28ubmV0MS8wLQYJKoZIhvcNAQkBFiB2bGFkaW1pci5sYXph
cmVua29AbG9naWNhY21nLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMhN
65wBwy12UD+rjqjhBDMm8/6sYE+YHQmJMgTb/Cxy+Sp00ISDel7/FiLvVtKAo667N43VeFzT
p+7BWKxC0OJAFddayiWFw5sZCEL28qY2lHnolrpJMbVIzUoqrSkPjgZ9GNI93Ri7AWkMCF9X
uRFW0I0Lbb2gYH2fnpdloO917DLyXVuBxOyPUpu1TeP+oHbi8whPdrhFx8Ep37sP13srk5tf
ISzaXdJzEVWOaLTyIL5tMSlCuBJibmcDm9/2qCLW+c1eAxiQwmafH4tJ5WPch2wclEXlt7tw
tGe6vK0Se2B8TvgZmOaY78wIp0DBVrP4+wsMnCbcPHtk+sY1d/8CAwEAAaNRME8wPwYDVR0R
BDgwNoESdmxhZEBsYXphcmVua28ubmV0gSB2bGFkaW1pci5sYXphcmVua29AbG9naWNhY21n
LmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBACfGbOm/RbyWFmOR+w4Vk8XY
umCjlfqb+icqbKENKvuG4DOQr6QaTtRT+/ATA3yrooYfQWuflDIEPS+SbNyjfpNyyFiYB8OS
rfclJ+B+ikvEP7LweNoL3EV1SrzeyJ3YrcqHAhoNqvB66dVQCy04RFvaRI+fC3I79Zd748gf
ESqyMIIDSDCCArGgAwIBAgIDD5dKMA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTEwMDQxODI5NTZaFw0wNjEwMDQx
ODI5NTZaMIGYMRIwEAYDVQQEEwlMYXphcmVua28xETAPBgNVBCoTCFZsYWRpbWlyMRswGQYD
VQQDExJWbGFkaW1pciBMYXphcmVua28xITAfBgkqhkiG9w0BCQEWEnZsYWRAbGF6YXJlbmtv
Lm5ldDEvMC0GCSqGSIb3DQEJARYgdmxhZGltaXIubGF6YXJlbmtvQGxvZ2ljYWNtZy5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDITeucAcMtdlA/q46o4QQzJvP+rGBP
mB0JiTIE2/wscvkqdNCEg3pe/xYi71bSgKOuuzeN1Xhc06fuwVisQtDiQBXXWsolhcObGQhC
9vKmNpR56Ja6STG1SM1KKq0pD44GfRjSPd0YuwFpDAhfV7kRVtCNC229oGB9n56XZaDvdewy
8l1bgcTsj1KbtU3j/qB24vMIT3a4RcfBKd+7D9d7K5ObXyEs2l3ScxFVjmi08iC+bTEpQrgS
Ym5nA5vf9qgi1vnNXgMYkMJmnx+LSeVj3IdsHJRF5be7cLRnurytEntgfE74GZjmmO/MCKdA
wVaz+PsLDJwm3Dx7ZPrGNXf/AgMBAAGjUTBPMD8GA1UdEQQ4MDaBEnZsYWRAbGF6YXJlbmtv
Lm5ldIEgdmxhZGltaXIubGF6YXJlbmtvQGxvZ2ljYWNtZy5jb20wDAYDVR0TAQH/BAIwADAN
BgkqhkiG9w0BAQQFAAOBgQAnxmzpv0W8lhZjkfsOFZPF2Lpgo5X6m/onKmyhDSr7huAzkK+k
Gk7UU/vwEwN8q6KGH0Frn5QyBD0vkmzco36TcshYmAfDkq33JSfgfopLxD+y8HjaC9xFdUq8
3sid2K3KhwIaDarweunVUAstOERb2kSPnwtyO/WXe+PIHxEqsjGCAzswggM3AgEBMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0owCQYFKw4D
AhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUx
MDI3MTQzMTQ5WjAjBgkqhkiG9w0BCQQxFgQUwTP7fJlHysp9QZOEj6PazznkgTwwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw+XSjB6BgsqhkiG9w0BCRACCzFr
oGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0ow
DQYJKoZIhvcNAQEBBQAEggEABNz/gttwu+/L1R4TouOU04KEPvgwTHeht7W1DDKZpZ0/wMoP
mxydteCeRN9ssqJOI7E3LAs53JgTIBCZCD3JNR/FxZz+MUqYRbQ/2isWeGR1M2s1DTPq8zd5
kDZhpKNhQBAE+Zb10jCk3450uDfYJpzwfFNVu/l8TgIO374QkJhzcrqvQq7zGbjhP6/UCa/k
7xRhjhgsudxSUFxj5IrfRgyJoizd/5rwr7PO0YZ8UV/wgrAMQ75eWastfMkIAOi5c7V27xX4
wcl/89f811tjVQxCLqBP6KM/fDBk93zgnj9cCGzOUYD1ryTIrBY4HNuufkBOXHsUxsBkGLTm
E+CzEwAAAAAAAA==
--------------ms020902090503050106060304--

