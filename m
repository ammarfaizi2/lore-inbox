Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUCVTor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUCVTor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:44:47 -0500
Received: from smtp04.web.de ([217.72.192.208]:36385 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262351AbUCVToj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:44:39 -0500
From: Pascal Maillard <pascalmaillard@web.de>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: independence from ide master/slave
Date: Sat, 20 Mar 2004 18:40:31 +0100
User-Agent: Dei Mudda sei Gsischt
References: <Pine.LNX.4.44.0403201109110.20406-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0403201109110.20406-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403201819.43220.pascalmaillard@web.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for your answers. I didn't know of UUIDs and user defined labels and 
you're right, it is much more flexible. But, according to man fstab, it is 
currently only supported by ext2 and xfs. What about the others?

One last note about the term "current hd" I used: I did not define it as the 
hd where the root fs is located, but I said that it should be defined by the 
kernel at startup. That is, it could be any disk. The default could have 
been, for example, the root fs.

> perhaps you are thinking of the rather
> specialized case where a system has only one disk, and the root partition
> is on it.
Do you really think, that it is such a specialized case? I know that Linux is 
used much more on servers than on desktop computers, but I suppose we all 
hope that Linux' market share on desktops can grow further.

cö,
Pascal Maillard

Mark Hahn wrote:
> > filesystems were thought to be on /dev/hda. So I asked myself if there
> > should not be device files that point to the _current_ hard disk (which
> > should be defined at startup by the kernel) and its partitions.
>
> "current hd" has no meaning.  perhaps you are thinking of the rather
> specialized case where a system has only one disk, and the root partition
> is on it.  if so, you really mean "/dev/root" (which is a notional device
> that the kernel uses in /proc/mounts for instance - I don't know whether
> it has any assigned major/minor number that would let it appear in /dev.)
>
> note that RedHat has used a relatively simple mechanism called
> mount-by-label which permits the kind of cable/controller independence that
> you're asking for.  it's vastly more logical than your /dev/root approach,
> and extends beyond a single disk.
>
> > This way, it wouldn't
> > matter which IDE channel a disk is connected to. What do you mean about
> > this?
>
> mount by label.

