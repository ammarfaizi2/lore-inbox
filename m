Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSH0WY6>; Tue, 27 Aug 2002 18:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSH0WY5>; Tue, 27 Aug 2002 18:24:57 -0400
Received: from mailgate.bridgetrading.com ([62.49.201.178]:52419 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S315214AbSH0WY4>; Tue, 27 Aug 2002 18:24:56 -0400
Message-ID: <3D6BFCF4.8010909@Funderburg.com>
Date: Tue, 27 Aug 2002 23:28:04 +0100
From: "Chris Funderburg (at home)" <Chris@Funderburg.com>
Organization: DCi (Europe)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1b) Gecko/20020803
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.32
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090803060508090509010008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090803060508090509010008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


This is the closest I've come to actually being able to compile a kernel 
 > 2.5.25 yet...

But there seems to be one more problem at the very end:

   ld -m elf_i386  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.32/init'
  ld -m elf_i386 -T arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/init.o 
--start-group arch/i386/kernel/kernel.o arch/i386/mm/mm.o 
kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o security/built-in.o 
/usr/src/linux-2.5.32/arch/i386/lib/lib.a lib/lib.a 
/usr/src/linux-2.5.32/arch/i386/lib/lib.a drivers/built-in.o 
sound/sound.o arch/i386/pci/pci.o net/network.o --end-group -o vmlinux
net/network.o: In function `register_8022_client':
net/network.o(.text+0xf59f): undefined reference to `llc_sap_open'
net/network.o: In function `unregister_8022_client':
net/network.o(.text+0xf5ca): undefined reference to `llc_sap_close'
net/network.o: In function `snap_init':
net/network.o(.text.init+0x59d): undefined reference to `llc_sap_open'
make: *** [vmlinux] Error 1

Something missing an "include", or just some dodgy .config ???




--------------ms090803060508090509010008
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIOTCC
AoIwggHroAMCAQICAwZCAzANBgkqhkiG9w0BAQIFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAxMTIwNjExNDc1MloXDTAyMTIwNjExNDc1MlowRjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEjMCEGCSqGSIb3DQEJARYUY2hyaXNA
ZnVuZGVyYnVyZy5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMROMOmJDxoT3lQF
8md8j49wpLOGd/TRpfzpQriBrdVYnVJtd04KJQTHbTvvyAiL8e3jKhKmtaW6OAzQ+4OdEWDl
tU/yKhaxmtAQ1yoRf912zwWmjuKw0dznPao7Rzw5ycmalCitLivgk5v6C9W5PvYDgdZ0scMK
W9cQvnlqfCXLAgMBAAGjMTAvMB8GA1UdEQQYMBaBFGNocmlzQGZ1bmRlcmJ1cmcuY29tMAwG
A1UdEwEB/wQCMAAwDQYJKoZIhvcNAQECBQADgYEAJd+yHnmhJeoNQwwMYLc3PxNmlzf2NvjW
E8VbwVEVje0AAJRoymh5KDo2cf4wl3TTCzisHpisrE+ZBPwEZJlw8cj8gtbduC9lh0HufIS7
hX085jgHn9Eaci0UaHYyynI9JQeEJ8qvvhuKOO819ferfWZEVi975rsfVMJLR6oKQMIwggKC
MIIB66ADAgECAgMGQgMwDQYJKoZIhvcNAQECBQAwgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0w
GwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1h
aWwgUlNBIDIwMDAuOC4zMDAeFw0wMTEyMDYxMTQ3NTJaFw0wMjEyMDYxMTQ3NTJaMEYxHzAd
BgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIxIzAhBgkqhkiG9w0BCQEWFGNocmlzQGZ1
bmRlcmJ1cmcuY29tMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDETjDpiQ8aE95UBfJn
fI+PcKSzhnf00aX86UK4ga3VWJ1SbXdOCiUEx20778gIi/Ht4yoSprWlujgM0PuDnRFg5bVP
8ioWsZrQENcqEX/dds8Fpo7isNHc5z2qO0c8OcnJmpQorS4r4JOb+gvVuT72A4HWdLHDClvX
EL55anwlywIDAQABozEwLzAfBgNVHREEGDAWgRRjaHJpc0BmdW5kZXJidXJnLmNvbTAMBgNV
HRMBAf8EAjAAMA0GCSqGSIb3DQEBAgUAA4GBACXfsh55oSXqDUMMDGC3Nz8TZpc39jb41hPF
W8FRFY3tAACUaMpoeSg6NnH+MJd00ws4rB6YrKxPmQT8BGSZcPHI/ILW3bgvZYdB7nyEu4V9
POY4B5/RGnItFGh2MspyPSUHhCfKr74bijjvNfX3q31mRFYve+a7H1TCS0eqCkDCMIIDKTCC
ApKgAwIBAgIBDDANBgkqhkiG9w0BAQQFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdl
c3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3Vs
dGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UE
AxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25h
bC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAwMDgzMDAwMDAwMFoXDTAyMDgyOTIzNTk1OVow
gZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0ZSBTZXJ2aWNlczEo
MCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMDCBnzANBgkqhkiG9w0B
AQEFAAOBjQAwgYkCgYEA3jMypmPHCSVFPtJueCdngcXaiBmClw7jRCmKYzUqbXA8+tyu9+50
bzC8M5B/+TRxoKNtmPHDT6Jl2w36S/HW3WGl+YXNVZo1Gp2Sdagnrthy+boC9tewkd4c6avg
GAOofENCUFGHgzzwObSbVIoTh/+zm51JZgAtCYnslGvpoWkCAwEAAaNOMEwwKQYDVR0RBCIw
IKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDEtMjk3MBIGA1UdEwEB/wQIMAYBAf8CAQAw
CwYDVR0PBAQDAgEGMA0GCSqGSIb3DQEBBAUAA4GBAHMbbyZli/8VNEtZYortRL5Jx+gNu4+5
DWomKmKEH7iHY3QcbbfPGlORS+HN5jjZ7VD0Omw0kqzmkpxuwSMBwgmn70uuct0GZ/VQby5Y
uLYLwVBXtewc1+8XttWIm7eiiBrtOVs5fTT8tpYYJU1q9J3Fw5EvqZa4BTxS/N3pYgNIMYIC
pjCCAqICAQEwgZowgZIxCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQ
BgNVBAcTCUNhcGUgVG93bjEPMA0GA1UEChMGVGhhd3RlMR0wGwYDVQQLExRDZXJ0aWZpY2F0
ZSBTZXJ2aWNlczEoMCYGA1UEAxMfUGVyc29uYWwgRnJlZW1haWwgUlNBIDIwMDAuOC4zMAID
BkIDMAkGBSsOAwIaBQCgggFhMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTAyMDgyNzIyMjgwNFowIwYJKoZIhvcNAQkEMRYEFKhrKx+igsM16boSSuNjwW0F
t67KMFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqG
SIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGtBgsqhkiG9w0BCRACCzGBnaCB
mjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2Fw
ZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2Vz
MSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMGQgMwDQYJKoZI
hvcNAQEBBQAEgYBR4oK//K+yR2PTQFxVPUAoMpirvU66OGC+7fEFuRDDYfjIux6ZFhvysW0F
F4zg/ch+KvV1ubUQ4RbJ3mBDGrozElI3lPHNWFYVdTXEEWCBMO0uiq5OTN1CsEi9NmodvPK5
AbyB3u+zIogFBiR8oTfxNwDm0pE6bZJ7c0n9g9YvHQAAAAAAAA==
--------------ms090803060508090509010008--


