Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUHTOUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUHTOUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUHTOUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:20:43 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:18157 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267943AbUHTOUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:20:40 -0400
Date: Fri, 20 Aug 2004 15:19:09 +0100
From: Dave Jones <davej@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: jeremy@goop.org, linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] dothan speedstep fix
Message-ID: <20040820141909.GA16090@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Con Kolivas <kernel@kolivas.org>, jeremy@goop.org,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4125A036.8020401@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4125A036.8020401@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 04:54:46PM +1000, Con Kolivas wrote:

 > Now all I need is for a way to make it report the correct L2 cache.

How's this look ?

		Dave

Update Intel cache descriptor decoding to match latest
Intel Documentation (24161827.pdf)

Signed-off-by: Dave Jones <davej@redhat.com>

--- FC2/arch/i386/kernel/cpu/intel.c~	2004-08-20 15:15:32.049821280 +0100
+++ FC2/arch/i386/kernel/cpu/intel.c	2004-08-20 15:17:34.407220128 +0100
@@ -96,10 +96,13 @@
 	{ 0x70, LVL_TRACE,  12 },
 	{ 0x71, LVL_TRACE,  16 },
 	{ 0x72, LVL_TRACE,  32 },
+	{ 0x78, LVL_2,		1024 },
 	{ 0x79, LVL_2,      128 },
 	{ 0x7a, LVL_2,      256 },
 	{ 0x7b, LVL_2,      512 },
 	{ 0x7c, LVL_2,      1024 },
+	{ 0x7d, LVL_2,		2048 },
+	{ 0x7f, LVL_2,		512 },
 	{ 0x82, LVL_2,      256 },
 	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
