Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWJTAuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWJTAuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWJTAuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:50:21 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:2793 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751640AbWJTAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:50:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAKm4N0VThFhodGdsb2JhbACMHg
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.202):SA:0(0.6/5.0):. Processed in 2.185238 secs Process 8098)
Subject: Re: 2.6.18-rt6
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <20061018083921.GA10993@elte.hu>
References: <20061018083921.GA10993@elte.hu>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-WAWynNOPz4EekEBCiJJu"
Date: Fri, 20 Oct 2006 01:23:32 +0100
Message-Id: <1161303812.3020.15.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 20 Oct 2006 00:50:18.0760 (UTC) FILETIME=[B6DA7880:01C6F3E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WAWynNOPz4EekEBCiJJu
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I just test rt6 it in my problematic VIA Board with one PENTIUM D (DUAL)

1. don't apply cleaning to 2.16.18.1 (on sparc arch )
2. I usual boot with notsc (because without it give me many lost time
tickets)
    I try 2.16.18.1-rt6 without notsc and freeze on boot.=20
    I try with notsc and says=20
        Time: acpi_pm clocksource has been installed.
        Looks stable and don't show any lost timer ticket on dmesg.

But I want also work with Nvidia dri which is a close drive from NVIDIA.
I install that drive and I enable DRI, After a few minutes I got a
spontaneous reboot.
I will keep testing without nvidia close source.

And I like to know if this rt6 patch make this new clocksource (acpi_pm)
or just found it and use it ?=20

cat /sys/devices/system/clocksource/clocksource0/available_clocksource
acpi_pm jiffies
cat /sys/devices/system/clocksource/clocksource0/current_clocksource
acpi_pm

Thanks,=20



On Wed, 2006-10-18 at 10:39 +0200, Ingo Molnar wrote:
> i've released the 2.6.18-rt6 tree, which can be downloaded from the=20
> usual place:
>=20
>   http://redhat.com/~mingo/realtime-preempt/
>=20
> this is a fixes-mostly release. Changes since -rt4:
>=20
>  - fix for module loading / symbol table crash (John Stultz)
>  - scheduler fix (Mike Galbraith)
>  - fix x86_64 NMI watchdog & preempt-rcu interaction
>  - fix time-warp false positives
>  - jiffies_to_timespec export fix (Steven Rostedt)
>  - ll_rw_block.c warning fix (Mike Galbraith)
>  - PPC updates (Daniel Walker)
>  - MIPS updates (Manish Lachwani)
>  - ARM oprofile fix (Kevin Hilman)
>  - traditional futexes queued via plists (S=E9stien Dugu=E9se)
>  - (various other smaller fixes)
>=20
> to build a 2.6.18-rt6 tree, the following patches should be applied:
>=20
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt6
>=20
> as usual, bugreports, fixes and suggestions are welcome,
>=20
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
S=E9rgio M.B.

--=-WAWynNOPz4EekEBCiJJu
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjEwMjAwMDIzMjhaMCMGCSqGSIb3DQEJBDEWBBQavIVoVn8Lwa65kjKlKB0r
EsymEzANBgkqhkiG9w0BAQEFAASCAQAOUvmpd7KaQ8HiJBZZCVIL8AjpD8Whwqvu+qNGFMwsLaFE
EKtXnTSzwpolsQ3OVGZTrbQIHZbm3Hy3hWjYQmPt+mAEhO4HAR1/38+nfrFlC32HawTRFoNpupCd
CIhJY1lzCkM7Jze2MnpNr8VR+BeiJz/JA0YiDPiUlfiNhV822WOJHvBxRWi82C4f2bCUtyvGdeA9
BfhBO7do1hzXcK3cKlsQ4CTJ02s1UZQNoiF6KTyoKaGOcUnkU2gsrvDYXoMv6W/dtvt8wdkNBjmF
VBomAxBVHIO8dTY1vLRVn8sRE7LOddyK/bbGW5QHKdhem9Td6pflIZWHhnfpfB+9hQ1jAAAAAAAA



--=-WAWynNOPz4EekEBCiJJu--
