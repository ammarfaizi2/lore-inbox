Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVAJAsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVAJAsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVAJAsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:48:14 -0500
Received: from h151_115.u.wavenet.pl ([217.79.151.115]:9171 "EHLO
	alpha.polcom.net") by vger.kernel.org with ESMTP id S261654AbVAJArw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:47:52 -0500
Date: Mon, 10 Jan 2005 01:47:35 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Support for > 2GB swap partitions?
In-Reply-To: <Pine.LNX.4.61.0501091933090.29064@p500>
Message-ID: <Pine.LNX.4.60.0501100142070.27893@alpha.polcom.net>
References: <Pine.LNX.4.61.0501091933090.29064@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2005, Justin Piszcz wrote:

> I remember reading in the past that > 2GB swap partitions were supported in 
> Linux as of recent util-linux packages with a 2.6 kernel or am I wrong?
>
> # fdisk -l
>
> Disk /dev/sda: 251.0 GB, 251000193024 bytes
> 255 heads, 63 sectors/track, 30515 cylinders
> Units = cylinders of 16065 * 512 = 8225280 bytes
>
>   Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *           1          16      128488+  83  Linux
> /dev/sda2              17         526     4096575   82  Linux swap
> /dev/sda3             527       30515   240886642+  83  Linux
>
> # top
> top - 19:33:43 up  3:26,  1 user,  load average: 1.33, 2.63, 1.66
> Tasks: 166 total,   1 running, 165 sleeping,   0 stopped,   0 zombie
> Cpu(s):  9.1% us,  3.4% sy,  0.0% ni, 83.5% id,  1.8% wa,  0.1% hi,  2.2% si
> Mem:   2075192k total,  2062540k used,    12652k free,       64k buffers
> Swap:        0k total,        0k used,        0k free,  1608272k cached
>
>
> Only recognizes 2GB of 4GB?

No. It looks like you forgot to enable your swap at all! 2GB is your RAM. 
Your swap is 0.

Try
$ swapon /dev/sda2

or

$ swapon -a

if your swap is listed in /etc/fstab

(possibly with

$ mkswap /dev/sda2

before).

I am using 4 GB swaps on many machines (x86 and x86_64) for long time 
without any problems.


Grzegorz Kulewski

