Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTIQMgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTIQMgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:36:11 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:35857 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262739AbTIQMgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:36:09 -0400
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60>
	<20030914122034.C3371@pclin040.win.tue.nl>
	<206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60>
	<20030916154305.A1583@pclin040.win.tue.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 17 Sep 2003 21:35:22 +0900
In-Reply-To: <20030916154305.A1583@pclin040.win.tue.nl>
Message-ID: <87vfrr3851.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> writes:

> > > OGAWA Hirofumi posted a patch for the yen-sign pipe key on 2003.07.23
> > > for test1 but his patch still didn't get into test3.
> 
> I do not think his patch is needed.
> 
> So the question arises: do we need a kernel patch, and if so, what patch?
> The program loadkeys exists to load the kernel keymap with the map the user
> desires. So, if you need some particular map the obvious answer is:
> "use loadkeys".
> 
> There is a small snag - until 2.4 the value of NR_KEYS was 128,
> while 2.6 uses 256. Moreover, the keys you want to change are above 128.
> So, your old precompiled loadkeys will not do - you must recompile the
> kbd package against 2.6 kernel headers, or just edit loadkeys.y and dumpkeys.c
> inserting

in input.h
	#define KEY_MAX		0x1ff
in keyboard.h
	#define NR_KEYS		(KEY_MAX+1)

NR_KEYS is 512...  Or we should use 256, you mean?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
