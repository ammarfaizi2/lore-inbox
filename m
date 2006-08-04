Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161239AbWHDOnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161239AbWHDOnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWHDOnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:43:12 -0400
Received: from [212.76.86.19] ([212.76.86.19]:48900 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1161236AbWHDOnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:43:10 -0400
From: Al Boldi <a1426z@gawab.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Can someone explain under what condition inode cache pages can be swapped out?
Date: Fri, 4 Aug 2006 17:44:42 +0300
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Xin Zhao <uszhaoxin@gmail.com>
References: <4ae3c140608022315y675eed20hcefbb8fb0407f4a3@mail.gmail.com> <4ae3c140608030832n2124b8abu479b7b4ae3eda1f@mail.gmail.com> <Pine.LNX.4.61.0608040753030.8519@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0608040753030.8519@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608041744.42681.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
> > If my understanding is right, inode cache shrinker only frees the
> > reclaimable inodes, which means, if a lot of files are opened when
> > shrinker is activated, the shrinker may not find sufficient
> > reclaimable inodes to free enough space. What will Linux do under such
> > condition?
>
> Userspace will start to be swapped out to make room for kernel memory.
> And if the swap is full, the OOM killer comes into action and will kill
> programs.

The OOM-killing spree starts way before swap is full :(
see "swapping and oom-killer: gfp_mask=0x201d2, order=0" thread.


Thanks!

--
Al

