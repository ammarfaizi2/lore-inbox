Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVHDP2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVHDP2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbVHDP0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:26:01 -0400
Received: from gate.crashing.org ([63.228.1.57]:60346 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262560AbVHDPZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:25:11 -0400
Subject: Re: [PATCH] Remove suspend() calls from shutdown path
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050804121604.GA4659@gemtek.lt>
References: <1123148187.30257.55.camel@gaston>
	 <20050804121604.GA4659@gemtek.lt>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 17:20:44 +0200
Message-Id: <1123168844.30257.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 15:16 +0300, Zilvinas Valinskas wrote:
> Hello Ben, Andrew, 
> 
> This patch helps me if I disconnect all USB peripherals before shutting
> down notebook. With connected peripherals (USB mouse, PL2303
> USB<->serial converter/port) - powering off process stops right after
> unmounting filesystems but before hda power off ... 
> 
> There is a bug report for this too:
> http://bugzilla.kernel.org/show_bug.cgi?id=4992

This is unclear.

I would expect the behaviour you report to happen _without_ this patch,
that is with current git tree, and I would expect this patch to fix it
by reverting to the previous 2.6.12 behaviour...

Ben.


