Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbTIQRWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 13:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTIQRWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 13:22:22 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:9226 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262597AbTIQRWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 13:22:21 -0400
Date: Wed, 17 Sep 2003 19:22:16 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andries Brouwer <aebr@win.tue.nl>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030917192216.A2164@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <87vfrr3851.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87vfrr3851.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Wed, Sep 17, 2003 at 09:35:22PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 09:35:22PM +0900, OGAWA Hirofumi wrote:
> Andries Brouwer <aebr@win.tue.nl> writes:
> 
> > > > OGAWA Hirofumi posted a patch for the yen-sign pipe key on 2003.07.23
> > > > for test1 but his patch still didn't get into test3.

> > until 2.4 the value of NR_KEYS was 128, while 2.6 uses 256

> in input.h
> 	#define KEY_MAX		0x1ff
> in keyboard.h
> 	#define NR_KEYS		(KEY_MAX+1)
> 
> NR_KEYS is 512...  Or we should use 256, you mean?

Yes, I think so.

Maybe Vojtech can tell us why he wrote 512, but I just see a
large amount of wasted space (and, as you already pointed out,
the need for new ioctls) if one uses 512.

As far as I can see, everything works with 256.
Indeed, everything seems to assume 256.

Andries

