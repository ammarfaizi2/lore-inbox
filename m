Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTIUMji (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbTIUMji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:39:38 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:21010 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262004AbTIUMjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:39:37 -0400
Date: Sun, 21 Sep 2003 14:39:34 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, Norman Diamond <ndiamond@wta.att.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 vs. Japanese keyboards [3]
Message-ID: <20030921143934.A11315@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030914122034.C3371@pclin040.win.tue.nl> <206701c37ab2$6a8033e0$2dee4ca5@DIAMONDLX60> <20030916154305.A1583@pclin040.win.tue.nl> <20030921110629.GC18677@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030921110629.GC18677@ucw.cz>; from vojtech@suse.cz on Sun, Sep 21, 2003 at 01:06:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 01:06:29PM +0200, Vojtech Pavlik wrote:

> There is a slight problem, and that is that NR_KEYS is (KEY_MAX+1) in
> recent 2.6's and that's 512. And that doesn't fit into a byte. There
> were some patches floating around to enhance the keymap loading ioctls.
> They will be needed, along with a new version of loadkeys.

Yes - a lot of trouble.
As far as I can see, the space between 256 and 511 is never used.

More in particular, there are lots of places where the kernel
seems to assume that only 256 is used.

So, instead of requiring new ioctls and new loadkeys etc
I would prefer to make NR_KEYS 256, if possible.
So the question is: why did you require 512?

Andries

