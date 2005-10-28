Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVJ1VuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVJ1VuT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVJ1VuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:50:18 -0400
Received: from smtp06.wanadoo.nl ([194.134.35.146]:42506 "EHLO
	smtp06.wanadoo.nl") by vger.kernel.org with ESMTP id S1750772AbVJ1VuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:50:17 -0400
Message-ID: <43629D18.1050706@lazarenko.net>
Date: Fri, 28 Oct 2005 23:50:16 +0200
From: Vladimir Lazarenko <vlad@lazarenko.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Claudio Scordino <cloud.of.andor@gmail.com>
Cc: john stultz <johnstul@us.ibm.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug: timer going backward on a dual core
References: <200510282109.42054.cloud.of.andor@gmail.com> <200510282227.36433.cloud.of.andor@gmail.com> <1130532212.27168.417.camel@cog.beaverton.ibm.com> <200510282339.16196.cloud.of.andor@gmail.com>
In-Reply-To: <200510282339.16196.cloud.of.andor@gmail.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms090405090104030309090708"
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "dinosaur.lazarenko.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >>>>>We have a dual-core AMD64 with the new kernel
	2.6.14 and the >>>>>timer goes backward... >>>>> >>>>>
	>>>>>CONFIGURATION: >>>>> >>>>>Kernel: 2.6.14 >>>>>Distribution: Gentoo
	Linux 2005.0 >>>>>Processor: Athlon 64 x2 4200+ (dual core)
	>>>>>Motherboard: Abit KN8 >>>>>Memory: 1GB PC3200 >>>>> >>>>>
	>>>>>PROBLEM: >>>>> >>>>>gettimeofday goes backward and returns values
	that are not monotonic, >>>>>giving values that are smaller than values
	returned before. >>>>> >>>>>The system has been tested with timer as
	PIT, PIT/TSC and PM and the >>>>>problem occurs with all the
	configurations. >>>>> >>>>>Here is the config file that we used for the
	PM configuration. >>>>> >>>>>Any suggestion ? >>>> >>>>Booting w/
	idle=poll tends to work around this issue. You might check >>>>with your
	motherboard vendor for an updated BIOS that supports HPET or >>>>the
	ACPI PM timer. >>> >>>We already updated the BIOS with the latest
	version. >>> >>>Also the booting command idle=poll doesn't work. >>
	>>Hmm. Not sure then. Is this a new regression on the same hardware? >
	Yes, we tried with idle=poll and the problem occurred again. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090405090104030309090708
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>>We have a dual-core AMD64 with the new kernel 2.6.14 and the
>>>>>timer goes backward...
>>>>>
>>>>>
>>>>>CONFIGURATION:
>>>>>
>>>>>Kernel: 2.6.14
>>>>>Distribution: Gentoo Linux 2005.0
>>>>>Processor: Athlon 64 x2 4200+ (dual core)
>>>>>Motherboard: Abit KN8
>>>>>Memory: 1GB PC3200
>>>>>
>>>>>
>>>>>PROBLEM:
>>>>>
>>>>>gettimeofday goes backward and returns values that are not monotonic,
>>>>>giving values that are smaller than values returned before.
>>>>>
>>>>>The system has been tested with timer as PIT, PIT/TSC and PM and the
>>>>>problem occurs with all the configurations.
>>>>>
>>>>>Here is the config file that we used for the PM configuration.
>>>>>
>>>>>Any suggestion ?
>>>>
>>>>Booting w/ idle=poll tends to work around this issue. You might check
>>>>with your motherboard vendor for an updated BIOS that supports HPET or
>>>>the ACPI PM timer.
>>>
>>>We already updated the BIOS with the latest version.
>>>
>>>Also the booting command idle=poll doesn't work.
>>
>>Hmm. Not sure then. Is this a new regression on the same hardware?
> Yes, we tried with idle=poll and the problem occurred again.

Very strange, idle=poll fixed it for us just fine.

Configuration we use is as follows:
Athlon 64 X2 3800+
Debian 32-bit
Tyan K8E
4G PC3200

Vladimir

--------------ms090405090104030309090708
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
MDI4MjE1MDE2WjAjBgkqhkiG9w0BCQQxFgQUqJGaWDKQg4MDzgFboLTo+m3aimswUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw+XSjB6BgsqhkiG9w0BCRACCzFr
oGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0ow
DQYJKoZIhvcNAQEBBQAEggEAnzsGuZQK8QzUBfKnLFD29EVE33NoHtCBxJVe+N9s0fF5ryvn
wqv+0wX2VHOVbTAICG5p7Nbg3oPrgVF2gFVYDyjr9/u4VFgIdKuMsHFETY187FP0JOQrRJQV
fLwSQXl96y2D97tl8Pqp98w7InO6LjXHwMPm/rRiDb9480Nuuy1S/Lxc23Tmxje2NiFcOheC
yyV0Fawq6nAorWK5pkeNPwBoHB96oMbFRuGeWDtgX2FN/B1s2YqsmldEfosrZ3wnqJFOfBW/
LASZJz9ha6FV8KMtLb+/klCz4fV7KVsV9d3CPzKuv/xl1Ino0GWEsKM7MlBJxsiy18m2tf9P
ra0fUwAAAAAAAA==
--------------ms090405090104030309090708--

