Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVHDPiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVHDPiE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVHDPfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:35:42 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:23755 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262585AbVHDPeA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:34:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=axYGloBDNjxRt/r/EaJRDU9w1nrWzjbnUwi8o8RxB3vAr8Qa9OeeJFXU0SPn70KiX6nCZGXG+wmwf097gFus4JJQKID7f6nkZzCK763bmE4wn5QgN3RNJLk5YsGrcSDYcl/ml5osvzplNyS4UCACuINkInxNppcdmqWCn4kRwuU=
Message-ID: <cce9e37e050804083347c138d4@mail.gmail.com>
Date: Thu, 4 Aug 2005 16:33:59 +0100
From: Phillip Lougher <phil.lougher@gmail.com>
Reply-To: Phillip Lougher <phil.lougher@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: squashfs seems nfs-incompatible
Cc: plougher@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508021710590.4634@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0508021710590.4634@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> I found out that you cannot mount an exported squash fs. The exports(5) fsid=
> parameter does not help it [like it did with unionfs].
> 


The exports(5) man page says fsid=num is necessary for filesystems on
non-block devices - I don't know whether this includes loopback
filesystems.  Have you tried exporting a Squashfs filesystem mounted
on a real block device?

I've never tried to export a Squashfs filesystem, and so I don't know
if it works.  If it doesn't, I would say it is because Squashfs (like
Cramfs) doesn't store correct nlink information for directories.

The next release does store nlink information, has support for > 4GB
files/filesystems, and other nice improvements.  I'm hoping to release
an alpha release soon.

Phillip
