Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVAJCU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVAJCU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVAJCU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:20:29 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:25354 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262053AbVAJCUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:20:23 -0500
Date: Mon, 10 Jan 2005 03:20:19 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support for > 2GB swap partitions?
Message-ID: <20050110022019.GL6052@pclin040.win.tue.nl>
References: <Pine.LNX.4.61.0501091933090.29064@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501091933090.29064@p500>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2005 at 07:34:38PM -0500, Justin Piszcz wrote:

> I remember reading in the past that > 2GB swap partitions were supported 
> in Linux as of recent util-linux packages with a 2.6 kernel or am I wrong?
> 
> # fdisk -l
> /dev/sda2              17         526     4096575   82  Linux swap
> 
> # top
> Mem:   2075192k total,  2062540k used,    12652k free,       64k buffers
> 
> Only recognizes 2GB of 4GB?

A swap partition has a swap header that specifies its size
(and possibly what bad blocks exist on the swap partition).
Thus, if you did mkswap long ago, the useful size will not
have changed. Do swapoff; mkswap; swapon and mkswap will
tell you how large a swap partition it made, and swapon
will cause the kernel to say how much swap space was added.
