Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUCHUi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUCHUiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:38:51 -0500
Received: from pop.gmx.net ([213.165.64.20]:34467 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261190AbUCHUhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:37:42 -0500
X-Authenticated: #1049660
Message-ID: <404CDA3D.50403@bitclown.de>
Date: Mon, 08 Mar 2004 21:40:29 +0100
From: Grischa Jacobs <grischa@bitclown.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] SiS900/RTL8201
Content-Type: multipart/mixed;
 boundary="------------010602010005090402020407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010602010005090402020407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I have a MSI MS-6701 with an onboard SiS900 network card. Using the 
linux kernel 2.4.23 and 2.6.[0-3] I experienced very low transfer rates 
of 200-300Kb/s. Looking at the boot messages, I found a number of 
entries about unknown PHY tranceivers at several addresses. Only at one 
address a Realtek RTL8201 PHY transceiver was found. By default the last 
transceiver, not the known one, was selected.

All but the recognised transceiver had a fault bit set. So I added two 
lines to take that bit into account. This allowed the known transceiver 
to be selected and resulted in increased transfer rates up to the 
expected 10-11Mb/s.

I don't have access to other SiS900 nics nor appropriate documentation 
to check my modifications. So I'd be glad if people with such cards 
could check or anybody with experience with nic drivers could comment on 
this patch.

Grischa Jacobs

--------------010602010005090402020407
Content-Type: application/octet-stream;
 name="patch-2.4.23-bc-sis900.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-2.4.23-bc-sis900.bz2"

QlpoOTFBWSZTWWuX0WQAAHVfgEI4Uf///2u/3iS/79/4QAI9C7a7QCVGkKfoQaamA0mnpNPU
9JpphAA002oMJoGhAU0xomFNqeiPUDQaABoNAADINJPIoyAAAAAAAAAAABKCKm9KY0R6TBBo
GgDEDIAND1AEUNIrsKoqxBWYTMKJtUbH8sPSXwYJWppSqVnWTiVRXBaKFLUVLmjbVbqNSWDC
Rj+9S781maZrjyo9dcuWXmwr1OQ0YJ1ZIatBce3QqtMzIRnC6ghex/dWXI1W+AjiSI1o+zPY
s1IrsEV7dfBi9uhOueNvuV9GUaZFEgtAxNk7WdC75xTuyP2xiY3OS2xcrEepYqamKhOUdLxJ
wwkpnPCaOV8YNkqhPy2LEAgZRiJAS/rkAgoo6pPKErwYXKjrJiMryB2hQ1KcDQMItjwlEwSA
ZqW24G1vgxo0RHpLBWPodcVIlO4kspPT6VqtVs4MMJlxHsOT0azaJ8OnyOUD+Cj8/NnpSKFM
macieaQuGiMExgPUcssMmW0QpqGnNSCZfogMg/MCHethsVsg89IJ4wMmfqYWfrh3Cb1uvzow
ZgrQKJWw7kCo1BdU5+OiII+5MOk7pfQnUTiUZADwlucKPZUIo5GgmUuYcwRCyKhXvFXTQJrb
ajjmdWNryCsXQEJgW+mR78KDGIxS97TEjpjK3hwKCL0aZBGs4rg9gHylrA4hbOJl1rDjFFdJ
iKwjC7zr6OpAcUxZba2OfABHpEgl50uBtDnFIKQcsGaTFAMmgG+QYtfNYF4m3qFLJi2HIkBZ
SPqVzRLAzWL5WFkqqcGLdQIg8dRbWoG5cF8o0eIFA1INtggEq5GA6w+bADBhj/8XckU4UJBr
l9Fk
--------------010602010005090402020407
Content-Type: application/octet-stream;
 name="patch-2.6.3-bc-sis900.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch-2.6.3-bc-sis900.bz2"

QlpoOTFBWSZTWckEwQcAAHXfgEI4Uf///2+/3yS/79/4QAJdsbbW0ASqYU09TT1E/UnqGTaJ
ptJpsiaaZAGjTRtENpNA0EApmUYKn+kiZG1PRA0AaZAPSABtQ4yZNGIYmmAgYE0wRgmJppoA
MIJQk0mmR6p6mE9EyepoABkaAGgGh6gB6GiWWFVHgrMh1iia1un+WP0+E1a1ySvJNYZf1wk6
IZAjIWZl6P3Sm4bkxGwOuEf6VE4qbIcm2r3D9YjPQ/bZZuoYNd7gOqBtaaWjPZqFleRJsN76
RJcx/br1Rj26ArXUuNSaSomQ16roqbrW64CkT5k9ckLNJx5sgwxvEQhISs5OhXcihzFGQiXY
GJxLtpsCEc7ZJarynpCmLLdrDv6YzKeMkfFAYFlKmyEJ8bkGJukcRDxMQ4pVVSKNRyppR6mE
N2QYrRQKGmwlAvBhanIRQpC1BZHQlgk2ItixrWHEjLhNi1xVXx0cZK3Eh6vDlBRfOzCaCWhN
qJxPys1i5hWhR3Ny56keFUjMsB55I6iUZK5iM44nYZOq4RVQMeBoX0Z0n8un+XUnehRObdrG
+ukT5tVgc1F9WdY7tFfqH4IUb0hd4mKOP2oLEC763H15skF+GzFXdHX2a2bc25mMKyyFs3wW
Bp2ij2VB44fQSqYN66DwtKhehLhLF1AmjTUoUfReN0QFypwBScGxwpGsvWijjExlGLjox95l
2/LgoRm91gWSy7og4h+Eq0QIQC48GoMcxjzF+V5iOsjDI+GFiwriBEri4cmPhpAQ5QwPT6k7
gehiECmMgc9Tew8QZOBwmLuLSF16HRuY1hhxtCuOYrePza9wS2ZmgkVS5cMHhrH3SEB0DENh
49SFoNHiZTVIIo5H76BcfM4HkJabgYMWh0f+LuSKcKEhkgmCDg==
--------------010602010005090402020407--
