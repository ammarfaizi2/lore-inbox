Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272223AbTGYQzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 12:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272224AbTGYQzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 12:55:19 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2827
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272223AbTGYQzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 12:55:15 -0400
Date: Fri, 25 Jul 2003 10:10:23 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: ahljoh@uni.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: directory inclusion in ext2/ext3
Message-ID: <20030725171023.GL1176@matchmail.com>
Mail-Followup-To: ahljoh@uni.de, linux-kernel@vger.kernel.org
References: <20030724034833.5D63B371@mendocino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030724034833.5D63B371@mendocino>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 05:48:34AM +0200, Johannes Halmann wrote:
> On Thu, 24 Jul 2003 03:00:17 +0200 Mike Fedyk wrote:
> >> my idea of solving this is to have
> >> an inclusion directive in directory-files...
> >> 
> >> has nobody ever felt the lack of such functionality??
> 
> > What exactly does this help you to do?
> > What do you want to accomplish?
> 
> hmm, i have a lot of huge files on different hard drives and wish to access 
> them in a uniform fashion. i would like to sort ALL files in subdirectories 
> but have no need for an LVM, RAID or similar. for example:
> 
> /mnt/drive1/category1
> /mnt/drive1/category2
> /mnt/drive2/category1
> /mnt/drive2/category2
> 
> (the data is so huge, that it is not possible to always merge categories on a 
> single disk!)
> what i would like to do now is to be able to display all files of "cat1" and 
> "cat2" respectively in "/mnt/union/category1" and "/mnt/union/category2". yet 
> i don't wish to simply link the directories as this would complicate access 
> with growing number of hard drives the data is spread on!
> 
> it's a bit weird to explain, i hope it's understandable now :-)))

Yes, I understand a little better.

But it just looks more like a good use for LVM than before.

You don't want the redundancy of raid, and are always adding space, so LVM
should be perfect for you.

Just use a nice filesystem that resizes easily, (or even online (while
mounted, etc)), and you're set.

Mike
