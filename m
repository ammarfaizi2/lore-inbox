Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752435AbVHGRZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752435AbVHGRZY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbVHGRZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:25:23 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:50601 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1752435AbVHGRZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:25:22 -0400
Date: Sun, 7 Aug 2005 19:25:14 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Regression: radeonfb: No synchronisation on CRT with linux-2.6.13-rc5
In-Reply-To: <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
Message-ID: <Pine.LNX.4.58.0508071921540.3495@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz> <1123195493.30257.75.camel@gaston>
 <Pine.LNX.4.58.0508051935570.2326@be1.lrz> <1123401069.30257.102.camel@gaston>
 <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Aug 2005, Kyle Moffett wrote:
> On Aug 7, 2005, at 03:51:07, Benjamin Herrenschmidt wrote:

> > Ah ! Interesting... I don't see why PREEMPT would affect radeonfb
> > though ... Can you try something like wrapper radeon_write_mode() with
> > preempt_disable()/preempt_enable() and tell me if it makes a
> > difference ?

Did not help. The values used to initialize the mode seem to be wrong.
Copying the aty directory from 2.6.12 did not help, too.

-- 
"Never tell the Platoon Sergeant you have nothing to do."
-Unknown Marine Recruit
