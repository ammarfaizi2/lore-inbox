Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270426AbTHGQFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270283AbTHGP7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 11:59:55 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:34216 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S270322AbTHGP4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:56:12 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Steven Newbury <s_j_newbury@yahoo.co.uk>, davidel@xmailserver.org
Subject: Re: SCHED_SOFTRR patch
Date: Thu, 7 Aug 2003 16:59:03 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <20030728202750.73149.qmail@web60001.mail.yahoo.com>
In-Reply-To: <20030728202750.73149.qmail@web60001.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071659.03894.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 July 2003 21:27, Steven Newbury wrote:
> While testing SCHED_SOFTRR with XMMS I had to modify XMMS slightly since it
> usually checks for uid 0 before enabling SCHED_RR.

Oh good, then you won't have any problem with modifying the kernel to put in a 
printk or two ;-)

> Under 2.6.0-test1 based kernels I have experienced quite a lote of
> drop-outs with XMMS playing mp3's with a moderate load, however, when run
> as root (with SCHED_RR) I encountered no drop-outs at all.  When using
> SOFTRR under I had very choppy playback when the machine was under load. 
> It was a constant jittering more than intermittent drop-outs.

According to me, this should not happen, since your cpu usage is well below 
what is supposed to be the cutoff for the realtime slice.  I've only seen one 
report like yours, where SOFTRR isn't working as intended.  On the other 
hand, I've missed a lot of lkml traffice lately, so there could be more.

What kind of system is this?  Is it a laptop with speedstep?

Regards,

Daniel

