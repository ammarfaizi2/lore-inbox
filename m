Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271691AbTHDJxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 05:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271692AbTHDJxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 05:53:12 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:55055 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271691AbTHDJxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 05:53:11 -0400
Date: Mon, 4 Aug 2003 11:53:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: adri <adriano.archetti@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1/2 won't let me use keyboard
Message-ID: <20030804095310.GA4420@win.tue.nl>
References: <20030728214523.GA485@inwind.it> <20030729142025.GA2180@win.tue.nl> <20030730072708.GA893@inwind.it> <20030802223740.GA655@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802223740.GA655@inwind.it>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 03, 2003 at 12:37:40AM +0200, adri wrote:

> but here the problem is the same: when i press a key it seems that i
> press this keys for almost 4 time (eg. i press "a", and it give me
> "aaaa")
> when i try to stop my system, i pressed alt+sysrq, +s, for sync, +u for
> mounting read only, and i mistake and pressed alt+sysrq+i, so i killed
> every task.
> well, i noticed here, with debug still on, that when i pressed a key, it
> received only one pressure:
> drivers/input/serio/i8042.c: 0c <- i8042 (interrupt, kbd, 1) [168545]
> but it write to standard output for characters.

Yes, thanks for confirming. The new input code generates the repeat
synthetically, by setting a timer, and that code must be buggy.

