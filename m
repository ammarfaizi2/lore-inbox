Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTL1MpH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 07:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTL1MpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 07:45:07 -0500
Received: from smtp7.hy.skanova.net ([195.67.199.140]:62402 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261193AbTL1MpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 07:45:00 -0500
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 and mice
References: <173901c3cceb$02d68560$43ee4ca5@DIAMONDLX60>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Dec 2003 12:49:41 +0100
In-Reply-To: <173901c3cceb$02d68560$43ee4ca5@DIAMONDLX60>
Message-ID: <m2pte9cgbu.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Norman Diamond" <ndiamond@wta.att.ne.jp> writes:

> On a machine with an Alps touchpad, I have built 2.6.0 several times.
...
> 2.  Also in Input device support, there is a section on Mice, PS/2 mouse,
> and Synaptics TouchPad.  These I compiled in and they don't seem to be
> causing any problems.  It seems that the Alps TouchPad is being recognized
> as an Intelli/Wheel mouse instead of being recognized as a Synaptics
> TouchPad, which is unfortunate but not really causing any problems.  I've
> read that Synaptics is most common in foreign countries but Alps is most
> common in Japan.

The synaptics kernel driver doesn't try to recognize alps touchpads.
However, in the XFree86 driver

        http://w1.894.telia.com/~u89404340/touchpad/index.html

there is a kernel patch (alps.patch) that makes the kernel recognize
alps touchpads and generate data compatible with the XFree86 synaptics
driver.

It doesn't work perfectly though, at least not for some hardware. The
problem seems to be how to interpret the gesture bit in the alps mouse
packets. Unfortunately I can't debug this problem myself, because I
don't have the hardware and there doesn't seem to be any public
documentation available for alps touchpads.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
