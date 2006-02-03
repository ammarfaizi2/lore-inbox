Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWBCRCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWBCRCa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWBCRCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:02:30 -0500
Received: from erik-slagter.demon.nl ([83.161.107.130]:13549 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S1751235AbWBCRC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:02:29 -0500
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
From: Erik Slagter <erik@slagter.name>
To: Juhani Rautiainen <juhani.rautiainen@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, Joerg Sommrey <jo@sommrey.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, tony@atomide.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <fad2c7740602030759i65e45a6as29964b8e90aeecd7@mail.gmail.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com>
	 <fad2c7740602030759i65e45a6as29964b8e90aeecd7@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-mWQAMzPx2qt796kw0oNE"
Date: Fri, 03 Feb 2006 18:02:15 +0100
Message-Id: <1138986135.18273.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-3.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mWQAMzPx2qt796kw0oNE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-02-03 at 17:59 +0200, Juhani Rautiainen wrote:

> This comes from AMD-768 revision guide. In product errata there there
> is errata number
> 24 which seems to suggest that you can't enable POS, C2 or C3 states
> in single processor
> environments. This at the end of errata:
> ----- snip ----
> This workaround will not work for awaking from the C2/C3 state, since
> the operating
> system has full control. The (ACPI C2/C3) state support is not
> required for Microsoft-compatible workstation and server platforms.
>=20
> It is recommended that BIOS should disable the C2 state by
> clearing bit C2EN (device B function 3 offset 4F'h). It is recommended
> that BIOS should disable the C3 state by clearing bit C3EN (device B
> function 3 offset 4F'h).
> ---- snip ----
>=20
> If I understand errata correctly then enabling C2/C3 should be safe in
> SMP environment put
> not in single processor enviroment. Maybe module should check this
> before enabling C3.

This is a very cryptic text! What would they mean actually?

That you cannot use POS/C* states in a single processor system OR in SMP
system that only has one processor fitted? Also this bug seems very odd
to me, what would the number of processors have to do with the
availability of C states?

Why "is the C2/C3 state support not required for Microsoft-compatible
platforms"? Do they mean it is okay (in their vision) to have these
running at full power all of the time? Or do they mean there is some
sort of driver that replaces the functionality?

My BIOS (Tyan S2466) does something completely different. It offers an
option "ACPI power saving" (or something like that) in the configuration
screen. This seems to toggle the above mentioned registers. But at the
same time it always marks C2 and C3 unusable by offering impossible
timings. This looks to me that the intention was to have C2/C3 enabled,
but only with this "special" windows driver that does some "extra"
things.

Grmbl, it's all sick.

Does *anyone* have some sort of contact with AMD or Tyan?

--=-mWQAMzPx2qt796kw0oNE
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
MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA2MDIwMzE3MDIxNVow
IwYJKoZIhvcNAQkEMRYEFFWkGKHnr5amftowfzrtZ89eumAgMHgGCSsGAQQBgjcQBDFrMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMP8QQwegYLKoZIhvcNAQkQ
Agsxa6BpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIDD/EEMA0G
CSqGSIb3DQEBAQUABIGAR4I7ooLIx4y/zKI4cs/NWlYd99OhpQX4RqR0ZVc1KrSUMPfEDH3D6kQ9
KQgaj88vIjwregDRGLNzzqUn0gztPRMLNz1+1Wjdl3/9c+9RgNUqk5Y3uIv68ys0RZcD2oFa5bMF
PyuDmJbpgKSloT0HBYXceqpNgpUKujWaQn1C7sUAAAAAAAA=


--=-mWQAMzPx2qt796kw0oNE--
