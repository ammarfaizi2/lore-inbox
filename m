Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVAJKKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVAJKKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 05:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVAJKKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 05:10:31 -0500
Received: from lucidpixels.com ([66.45.37.187]:20120 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262193AbVAJKKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 05:10:25 -0500
Date: Mon, 10 Jan 2005 05:10:22 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Andries Brouwer <aebr@win.tue.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Support for > 2GB swap partitions?
In-Reply-To: <20050110022019.GL6052@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.61.0501100510000.27243@p500>
References: <Pine.LNX.4.61.0501091933090.29064@p500> <20050110022019.GL6052@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was the problem, thanks!

On Mon, 10 Jan 2005, Andries Brouwer wrote:

> On Sun, Jan 09, 2005 at 07:34:38PM -0500, Justin Piszcz wrote:
>
>> I remember reading in the past that > 2GB swap partitions were supported
>> in Linux as of recent util-linux packages with a 2.6 kernel or am I wrong?
>>
>> # fdisk -l
>> /dev/sda2              17         526     4096575   82  Linux swap
>>
>> # top
>> Mem:   2075192k total,  2062540k used,    12652k free,       64k buffers
>>
>> Only recognizes 2GB of 4GB?
>
> A swap partition has a swap header that specifies its size
> (and possibly what bad blocks exist on the swap partition).
> Thus, if you did mkswap long ago, the useful size will not
> have changed. Do swapoff; mkswap; swapon and mkswap will
> tell you how large a swap partition it made, and swapon
> will cause the kernel to say how much swap space was added.
>
