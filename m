Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751698AbWKBEXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbWKBEXo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 23:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWKBEXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 23:23:44 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:32471 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1751696AbWKBEXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 23:23:43 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAMkBSUVThFhodGdsb2JhbACMSQE
X-IronPort-AV: i="4.09,379,1157324400"; 
   d="p7s'?scan'208"; a="120019100:sNHT24773283"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.72):SA:0(0.6/5.0):. Processed in 3.738314 secs Process 27775)
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Dave Jones <davej@redhat.com>
Cc: Stephen Clark <Stephen.Clark@seclark.us>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061102030353.GA2797@redhat.com>
References: <4548DDF4.2030903@seclark.us>
	 <20061101201218.GA4899@martell.zuzino.mipt.ru>
	 <45490EFE.1060608@seclark.us> <20061101235546.GB10577@redhat.com>
	 <4549450F.3080207@seclark.us>  <20061102030353.GA2797@redhat.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-dejULiOWRiR+RvZuEVvo"
Date: Thu, 02 Nov 2006 04:23:29 +0000
Message-Id: <1162441409.7677.23.camel@monteirov>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
X-OriginalArrivalTime: 02 Nov 2006 04:23:41.0866 (UTC) FILETIME=[AD7828A0:01C6FE36]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dejULiOWRiR+RvZuEVvo
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-01 at 22:03 -0500, Dave Jones wrote:
> On Wed, Nov 01, 2006 at 08:08:31PM -0500, Stephen Clark wrote:
>=20
>  > booting without lapic allowed it to boot but now I get
>  > ...
>  > Local APIC disabled by BIOS -- you can enable it with "lapic"
>  > ...
>  > Local APIC not detected. Using dummy APIC emulation.
>  >   which means more processor overhead - right?
>  >=20
>  > also cpuspeed doesn't work anymore - I don't have a cpufreq dir
>=20
> The Duron had powernow ?

This story of trying enable lapic when BIOS don't, has been triggered on
kernel2.6.18, but in my opinion is not a bug if lapic on those computers
don't work.

If you boot without enable lapic, you will see cat /proc/interrupts with
interrupts in XT-PIC.
if you try enable lapic, somehow IRQ routing should change=20
and if /proc/interrupts still the same, with IRQs in XT-PIC.
I think, lapic still not enabled and the most you can get it's problems.
Unless you know that lapic works (it is programmed and BIOS wrongly
disable it), you shouldn't try enable lapic because it is probable that
just give problems, to you.=20
Historically: In 2002/3 was a very common bug, when kernel was compiled
to support lapic and try enable lapic (even when BIOS don't) and
computer hangs on boot.=20
--=20
S=E9rgio M.B.

--=-dejULiOWRiR+RvZuEVvo
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
SIb3DQEJBTEPFw0wNjExMDIwNDIzMjJaMCMGCSqGSIb3DQEJBDEWBBQnNGL4MHZFIET2skWSHcmU
UHUonzANBgkqhkiG9w0BAQEFAASCAQBty1VhmsNUGXPyFolGIIa+u+n8g0ydqil0KnqEj6HVEKof
i1pW+Mqi1u5jMdxMsFynsnoDCvmuR7R7PZmkXpTUuAmXeuVUd2yzx/+9K7QzEhgqgqfz0Sc7youo
WUrG75DanhBDZljxkfBKI/0+m3xsy1LYSridD+JxaYos3yNfXdoVXeyhOAPQXBefuMZlkBKaxiwX
ycACzbe45/eV5xkzgM2B/kkYGeRP50+1hq+WlWmPJNne9mJ4qDuETvVF39HcFEFRmJUgN7LR1H1j
gCpvPdngBkcwL7WiBOdpbHUWoZZS1/S467v9DYMWSZBkdl5/E3aIpoNRbzZJPLqMPU92AAAAAAAA



--=-dejULiOWRiR+RvZuEVvo--
