Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUG0QiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUG0QiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUG0QiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:38:20 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:61454 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S266208AbUG0Qh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:37:58 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, aebr@win.tue.nl, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040726154327.107409fc.akpm@osdl.org>
	<20040727134654.GB17362@ucw.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 28 Jul 2004 01:37:00 +0900
In-Reply-To: <20040727134654.GB17362@ucw.cz>
Message-ID: <878yd5be4z.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> > This all seems a bit inconclusive.  Do we proceed with the original patch
> > or not?  If not, how do we fix the overflow which Hirofumi has identified?
> 
> I think we should check the value in the ioctl, regardless of what's
> NR_KEYS defined to.

However, it breaks the current binary instead. (at least
console-tools, kbdutils).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
