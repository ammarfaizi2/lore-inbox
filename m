Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751561AbWCTEoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbWCTEoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 23:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWCTEoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 23:44:12 -0500
Received: from amdext4.amd.com ([163.181.251.6]:62695 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1751557AbWCTEoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 23:44:10 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Sun, 19 Mar 2006 21:54:54 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Adrian Bunk" <bunk@stusta.de>
cc: info-linux@ldcmail.amd.com, linux-kernel@vger.kernel.org
Subject: Re: Why doesn't MGEODE_LX enable X86_TSC?
Message-ID: <20060320045454.GA15963@cosmic.amd.com>
References: <LYRIS-4270-36981-2006.03.19-15.00.48--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
In-Reply-To: <LYRIS-4270-36981-2006.03.19-15.00.48--jordan.crouse#amd.com@whitestar.amd.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 20 Mar 2006 04:40:51.0496 (UTC)
 FILETIME=[7767FA80:01C64BD8]
X-WSS-ID: 6800EDD91VK10293907-01-01
Content-Type: multipart/mixed;
 boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On 19/03/06 22:59 +0100, Adrian Bunk wrote:
> Is it accidental that CONFIG_MGEODE_LX doesn't enable CONFIG_X86_TSC or 
> is there a reason for this?

Totally accidental.   Thanks for pointing that out.  Just for completeness,
here's the patch if it hasn't already been fixed.

Jordan
--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--HcAYCG3uE/tztfnV
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=tsc.patch
Content-Transfer-Encoding: 7bit

[PATCH] Enable TSC for AMD Geode GX/LX

Geode GX/LX should enable X86_TSC.   Pointed out by Adrian Bunk.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/i386/Kconfig.cpu |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/Kconfig.cpu b/arch/i386/Kconfig.cpu
index 79603b3..eb13048 100644
--- a/arch/i386/Kconfig.cpu
+++ b/arch/i386/Kconfig.cpu
@@ -311,5 +311,5 @@ config X86_OOSTORE
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1 || MGEODE_LX) && !X86_NUMAQ
 	default y

--HcAYCG3uE/tztfnV--

