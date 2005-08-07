Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVHGHzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVHGHzw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 03:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVHGHzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 03:55:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:49874 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751222AbVHGHzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 03:55:52 -0400
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
	linux-2.6.13-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
	 <1123195493.30257.75.camel@gaston>
	 <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 09:51:07 +0200
Message-Id: <1123401069.30257.102.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 19:38 +0200, Bodo Eggert wrote:
> On Fri, 5 Aug 2005, Benjamin Herrenschmidt wrote:
> 
> > On Fri, 2005-08-05 at 00:03 +0200, Bodo Eggert wrote:
> > > My CRT is out of sync after radeonfb from 2.6.13-rc5 is initialized. 
> > > 2.6.12 does not show this behaviour.
> > 
> > I'm out of town at the moment, could you maybe diff radeonfb between
> > working & non-working and CC me the diff ? I don't have my work stuff at
> > hand not my kernel images so...
> 
> There were no changes in radeonfb.c, but I could trace to to 
> CONFIG_PREEMPT. With _NONE, it works as expected.

Ah ! Interesting... I don't see why PREEMPT would affect radeonfb
though ... Can you try something like wrapper radeon_write_mode() with
preempt_disable()/preempt_enable() and tell me if it makes a
difference ?

Ben.


