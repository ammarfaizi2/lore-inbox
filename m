Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWBAKZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWBAKZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWBAKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:25:21 -0500
Received: from erik-slagter.demon.nl ([83.161.107.130]:7624 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S932397AbWBAKZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:25:20 -0500
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
From: Erik Slagter <erik@slagter.name>
To: Andrew Morton <akpm@osdl.org>
Cc: Joerg Sommrey <jo@sommrey.de>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       arjan@infradead.org, Tony Lindgren <tony@atomide.com>
In-Reply-To: <20060131193446.7904ac6f.akpm@osdl.org>
References: <20060131185516.GA21769@sommrey.de>
	 <20060131193446.7904ac6f.akpm@osdl.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-QDvErafG8h0ffd0QHAcf"
Date: Wed, 01 Feb 2006 11:25:16 +0100
Message-Id: <1138789516.4449.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-3.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QDvErafG8h0ffd0QHAcf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-31 at 19:34 -0800, Andrew Morton wrote:
> > This is a processor idle module for AMD SMP 760MP(X) based systems.
> >  The patch was originally written by Tony Lindgren and has been around
> >  since 2002.  It enables C2 mode on AMD SMP systems and thus saves
> >  about 70 - 90 W of energy in the idle mode compared to the default idl=
e
> >  mode.  The idle function has been rewritten and is now free of locking
> >  issues and is independent from the number of CPUs.  The impact
> >  from this module on the system clock and on i/o transfer are now fairl=
y
> >  low.

Very nice, but I do have problems with it (last tested version about a
month ago).

I have a Tyan S2466 (760/8MPX) motherboard with a Promise PDC20575
(SATAII150 TX2plus), with two disks configured as raid-1. As soon as C2
starts to kick in (or C3 that doesn't matter) my syslog/dmesg starts to
fill up with error messages from the attached disks and one of the two
(at random) disks is kicked out of the raid. It looks like the other
disk keeps functioning although it keeps spewing lots of error messages.

To me it looks like the Promise controller goes totally bunkus when one
single interrupt is not served, or when it cannot bus master within a
certain time interval. I have tried to work around this problem by using
_very_ conservative values for the irq-watcher. This works well for some
time, but sooner or later the problem re-appears.

So it looks like the only way is to tackle the source of the problem. I
already reported this on linux-ide, but no response. I assume they think
it's a amd76x_pm specific issue.

--=-QDvErafG8h0ffd0QHAcf
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIILzCCAnIw
ggHboAMCAQICAw/xBDANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI5MTc0MTQ0WhcNMDYxMTI5MTc0MTQ0WjBqMRAwDgYDVQQE
EwdTbGFndGVyMRUwEwYDVQQqEwxFcmlrIE1hcnRpam4xHTAbBgNVBAMTFEVyaWsgTWFydGlqbiBT
bGFndGVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFtZTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEAtYqGuTSGbsTHZPiKQnNmvpVaxVuBZS6rV5xuKD47J9hz8Vq3Xh4PpuGYNW5L
vevp80oj6sYAhNuU380UNRqALFaer8MtG6fXpvBgq+MCxVQzMyYxAnopqWlZQIUQNQX9wZmI0gVv
gY6vwcXRBXkMyrzm41dy4oFwh+PTj3U+xwcCAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0BzbGFn
dGVyLm5hbWUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCf5+l4khcSjUOL8WcuJ7Q1
eXhSPe0VJEsHSfVJCNFmfFZFiGZNwQRliOuGFxSy+uPb8ZVIZ3cBIen/K0k2hWS6pCiDm3xNdkFU
mhWsibmyMoc91I0Re2ZWPmL6isxiyr56Qv7vNz2UHSinLJr/QtsvRv/RKFlcO1gm1wsCOPkyITCC
AnIwggHboAMCAQICAw/xBDANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI5MTc0MTQ0WhcNMDYxMTI5MTc0MTQ0WjBqMRAwDgYD
VQQEEwdTbGFndGVyMRUwEwYDVQQqEwxFcmlrIE1hcnRpam4xHTAbBgNVBAMTFEVyaWsgTWFydGlq
biBTbGFndGVyMSAwHgYJKoZIhvcNAQkBFhFlcmlrQHNsYWd0ZXIubmFtZTCBnzANBgkqhkiG9w0B
AQEFAAOBjQAwgYkCgYEAtYqGuTSGbsTHZPiKQnNmvpVaxVuBZS6rV5xuKD47J9hz8Vq3Xh4PpuGY
NW5Lvevp80oj6sYAhNuU380UNRqALFaer8MtG6fXpvBgq+MCxVQzMyYxAnopqWlZQIUQNQX9wZmI
0gVvgY6vwcXRBXkMyrzm41dy4oFwh+PTj3U+xwcCAwEAAaMuMCwwHAYDVR0RBBUwE4ERZXJpa0Bz
bGFndGVyLm5hbWUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQQFAAOBgQCf5+l4khcSjUOL8Wcu
J7Q1eXhSPe0VJEsHSfVJCNFmfFZFiGZNwQRliOuGFxSy+uPb8ZVIZ3cBIen/K0k2hWS6pCiDm3xN
dkFUmhWsibmyMoc91I0Re2ZWPmL6isxiyr56Qv7vNz2UHSinLJr/QtsvRv/RKFlcO1gm1wsCOPky
ITCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1
bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMT
G1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJl
ZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNa
LIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUq
VIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1Ud
HwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWls
Q0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVs
Mi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYf
qi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa
9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggJmMIICYgIBATBpMGIxCzAJ
BgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMAkGBSsOAwIaBQCgggFT
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MDIwMTEwMjUxMlow
IwYJKoZIhvcNAQkEMRYEFHe0T7HGPAvdNT1WBeNeOUwWKZAaMHgGCSsGAQQBgjcQBDFrMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMP8QQwegYLKoZIhvcNAQkQ
Agsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMA0G
CSqGSIb3DQEBAQUABIGARhU9tvfiE81OElmzgGMv8MNvZS0Ac5b7wW7N1GqATeKN8Roequp8jwf7
meS5eoQyHcrWMoN5qRvPLSVzeNRnw7boSl2no+GKzq9baEP0mbGamdT6tWQp6i7S9xS0HTNUT6jR
ENcTSCy2cBsPkh45llof7QHt0ZNhH9hFgBAiqEEAAAAAAAA=


--=-QDvErafG8h0ffd0QHAcf--
