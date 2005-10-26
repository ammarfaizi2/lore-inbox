Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVJZBD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVJZBD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVJZBD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:03:29 -0400
Received: from smtp06.wanadoo.nl ([194.134.35.146]:15394 "EHLO
	smtp06.wanadoo.nl") by vger.kernel.org with ESMTP id S932512AbVJZBD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:03:28 -0400
Message-ID: <435ED5E3.3060405@lazarenko.net>
Date: Wed, 26 Oct 2005 03:03:31 +0200
From: Vladimir Lazarenko <vlad@lazarenko.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Lazarenko <vlad@lazarenko.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Marc Perkel <marc@perkel.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_nv + SMP = broken?
References: <4358C417.9000608@lazarenko.net> <200510212238.25614.rjw@sisk.pl> <435A032C.7070302@lazarenko.net> <200510222040.53500.rjw@sisk.pl> <435A9A1B.4040907@lazarenko.net>
In-Reply-To: <435A9A1B.4040907@lazarenko.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070907080407020609090408"
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "dinosaur.lazarenko.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >>>>> I too am running an Athlon X2 using sata_nv. I
	have an ASUS >>>>> motherboard. But what I noticed was that the problem
	went away if I >>>>> used 2 gigs of ram instead of 4 gigs. When you use
	the whole 4 gigs >>>>> there is some memory mapping going on and I
	thought perhaps the >>>>> problem was related to the sata_nv not liking
	the memory mapped >>>>> over the 4gig barrier. >>>> That's possible.
	Unfortunately I cannot verify this, since there >>>> are 2GB of >>>> RAM
	in my box. >>>> >>>> I remeber someone having a problem with sata_nv
	DMAing over 2GB of RAM, >>>> so there may be something wrong with it.
	>>> On a second thought. Why would that only occur in SMP mode? Since
	now >>> the box is with 3G ram, no SMP and it works like a charm. If I
	enable >>> SMP - the hell breaks loose. >> It looks like an obscure
	issue. Apparently, to trigger it you need >> _both_ more that 2GB of RAM
	and SMP. > > > Looks like it. I played around today as well, and it
	seems to not to > occur with 2Gb. > >> OTOH, today I played with Tyan
	Thunder K8WE, based on the Nvidia >> CK8-04 chipset (not that much
	different to the regular Nforce4) in >> a 2-processor configuration and
	8GB of RAM, and it had no issues at all >> (I installed SuSE 9.3 with
	the distro kernel on it). Anyway its SATA >> controller is handled by
	the sata_nv driver, so the problem you describe >> does not seem to be
	software-related. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms070907080407020609090408
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>> I too am running an Athlon X2 using sata_nv. I have an ASUS 
>>>>> motherboard. But what I noticed was that the problem went away if I 
>>>>> used 2 gigs of ram instead of 4 gigs. When you use the whole 4 gigs 
>>>>> there is some memory mapping going on and I thought perhaps the 
>>>>> problem was related to the sata_nv not liking the memory mapped 
>>>>> over the 4gig barrier.
>>>> That's possible.  Unfortunately I cannot verify this, since there 
>>>> are 2GB of
>>>> RAM in my box.
>>>>
>>>> I remeber someone having a problem with sata_nv DMAing over 2GB of RAM,
>>>> so there may be something wrong with it.
>>> On a second thought. Why would that only occur in SMP mode? Since now 
>>> the box is with 3G ram, no SMP and it works like a charm. If I enable 
>>> SMP - the hell breaks loose.
>> It looks like an obscure issue.  Apparently, to trigger it you need 
>> _both_ more that 2GB of RAM and SMP.
> 
> 
> Looks like it. I played around today as well, and it seems to not to 
> occur with 2Gb.
> 
>> OTOH, today I played with Tyan Thunder K8WE, based on the Nvidia
>> CK8-04 chipset (not that much different to the regular Nforce4) in
>> a 2-processor configuration and 8GB of RAM, and it had no issues at all
>> (I installed SuSE 9.3 with the distro kernel on it).  Anyway its SATA
>> controller is handled by the sata_nv driver, so the problem you describe
>> does not seem to be software-related.

> Hehe, as if reading your mind I ordered Tyan K8E today, and in case that 
> won't work, i'll just put a pci raiser there and stuck an external SATA 
> from silicon image or promise there :)
> 
> I've heard from another person (thou have not seen it myself) that there 
> was kind of the same problem (hanging sata) on an opteron-based machine. 
> I was too late to ask the mb model thou, so this info is kind of 
> useless, but just for statistical purposes I mention it here.
> 
>> [Jeff, could you please say if this is a known problem?]

Ok, the last status update.
Tyan K8E arrived today, and after a short while (much longer while than 
on MSI motherboard thou) it started spitting out errors again (this is 
in SMP mode):

end_request: I/O error, dev sda, sector 35447511
raid1: sda3: rescheduling sector 27623856
raid1: sda3: redirecting sector 27623856 to another mirror
ATA: abnormal status 0xD0 on port 0x9F7
ATA: abnormal status 0xD0 on port 0x9F7
ATA: abnormal status 0xD0 on port 0x9F7
ata1: command 0x25 timeout, stat 0xd0 host_stat 0x1
ata1: status=0xd0 { Busy }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key: Aborted Command
      Additional sense: Scsi parity error

And so on, and so forth, with various blocks.
At this moment in time, the resync of 160G raid-1 was attempted in the 
background.

MSI mobo from the original mail had nForce4-SLi chipset, whereas this 
Tyan K8E has nForce4 Ultra.

Yet again, if i enable apic, the boot process hangs here:
sata_nv version 0.6
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 11
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 11

These are the last messages that I get. The same behaviour on both 
motherboard. Shoudl I enable apic, it hangs on that.

When I disable apic, the boot sequence looks like:

sata_nv version 0.6
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xDC00 irq 11
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xDC08 irq 11
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
88:407f
ata1: dev 0 ATA, max UDMA/133, 320173056 sectors: lba48
nv_sata: Primary device added
nv_sata: Primary device removed
nv_sata: Secondary device added
nv_sata: Secondary device removed
ata1: dev 0 configured for UDMA/133
scsi0 : sata_nv

... Thus, perfectly normal. Further on it goes onto ata2, and so on.

Hereby, the lspci from the new motherboard:
root@anarxi:~# lspci
0000:00:00.0 Memory controller: nVidia Corporation: Unknown device 005e 
(rev a3)
0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 0050 (rev a3)
0000:00:01.1 SMBus: nVidia Corporation: Unknown device 0052 (rev a2)
0000:00:06.0 IDE interface: nVidia Corporation: Unknown device 0053 (rev f2)
0000:00:07.0 IDE interface: nVidia Corporation: Unknown device 0054 (rev f3)
0000:00:09.0 PCI bridge: nVidia Corporation: Unknown device 005c (rev a2)
0000:00:0a.0 Bridge: nVidia Corporation: Unknown device 0057 (rev a3)
0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
0000:00:0c.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
0000:00:0d.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 005d (rev a3)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:06.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:01:07.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+]


And lspci -v from the IDE parts:

0000:00:06.0 IDE interface: nVidia Corporation: Unknown device 0053 (rev 
f2) (prog-if 8a [Master SecP PriP])
         Subsystem: Tyan Computer: Unknown device 2865
         Flags: bus master, 66MHz, fast devsel, latency 0
         I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2

0000:00:07.0 IDE interface: nVidia Corporation: Unknown device 0054 (rev 
f3) (prog-if 85 [Master SecO PriO])
         Subsystem: Tyan Computer: Unknown device 2865
         Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 11
         I/O ports at 09f0 [size=8]
         I/O ports at 0bf0 [size=4]
         I/O ports at 0970 [size=8]
         I/O ports at 0b70 [size=4]
         I/O ports at dc00 [size=16]
         Memory at febfd000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2


I'd very much appreciate some feedback on this. The box crashes every 
40-50 minutes in SMP mode, and without second core it's overloaded, and 
running on the edge of crash as well.

Let me know if i need to test anything or you want more info.

Thanks!

Regards,
Vladimir


--------------ms070907080407020609090408
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
MDI2MDEwMzMxWjAjBgkqhkiG9w0BCQQxFgQUz3E6ev5KVEkl60iuFeg75AARIgIwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw+XSjB6BgsqhkiG9w0BCRACCzFr
oGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0ow
DQYJKoZIhvcNAQEBBQAEggEACLJTg7lB12RCRVLDfq/rhNb/SeunDkB7MWdEXcKYtwEOvyhI
ArUUw1TNx1re1Pz0fttPO3k8L01Yt6TlWeTdNyTVLN9SKVfCa3HCnFf3Dvm/C0fbiICnn9rZ
7gohigGsJntNsD9gxiYMNB5VBIh/UoTz303VmunzUNbqylg7fKFDUn7muBNeLduDfmiEfqUA
cmZ7kaOuA8Jlrosw0OcCTi6rxDq/SQiIbA3BZ/0iFYDrN9yVGH6aXXLeY85EqE6HnNTSJpz9
I2rCagHkT+oBGxCJQKXh2PZRBi2azGFaEzLn/d/BKlo+5lxhrDLQmaw1OUMz6mzPeN82OWXx
JuEZXAAAAAAAAA==
--------------ms070907080407020609090408--

