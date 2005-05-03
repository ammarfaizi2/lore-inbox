Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVECRwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVECRwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 13:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVECRwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 13:52:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:1488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261489AbVECRwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 13:52:11 -0400
Date: Tue, 3 May 2005 10:52:02 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] PAL-M support fix for CX88 chipsets
Message-Id: <20050503105202.42fa5ffb.rddunlap@osdl.org>
In-Reply-To: <4277B833.9020109@brturbo.com.br>
References: <42777318.2070508@brturbo.com.br>
	<20050503083822.68a116d4.rddunlap@osdl.org>
	<4277B833.9020109@brturbo.com.br>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2005 14:43:15 -0300 Mauro Carvalho Chehab wrote:

| >On Tue, 03 May 2005 09:48:24 -0300 Mauro Carvalho Chehab wrote:
| >
| >|     This patch fixes PAL-M chroma subcarrier frequency (FSC) to its 
| >| correct value of 3.5756115 MHz and adjusts horizontal total samples for 
| >| PAL-M, according with formula Line Draw Time / (4*FSC), where Line Draw 
| >| Time is 63.555 us.
| >|      Without this patch, the Notch subcarrier filter was trying to 
| >| capture using NTSC-M frequency, which is very close, but not equal. This 
| >| could result in Black and White or miscolored frames.


This line:
+        static const unsigned int palm  = 28604892;
begins with spaces, not a TAB.


+	if (V4L2_STD_PAL_M  & norm->id) return palm;
Please only 1 space after the _M, and put the return on a
separate line.

Same comments for the next if/return.

And please clean up the next (final :) version with a
clean description and Signed-off-by: line.

---
~Randy
