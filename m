Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUFWSvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUFWSvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUFWStf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:49:35 -0400
Received: from quechua.inka.de ([193.197.184.2]:55725 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266605AbUFWSsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:48:03 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: I/O Confirmation/Problem under 2.6/2.4
Organization: Deban GNU/Linux Homesite
In-Reply-To: <1088012966.1347.28.camel@solaris.skunkware.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BdCmu-0000s6-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 23 Jun 2004 20:48:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I do have some additional questions to help others to better diagnose your
problem. Currently I am suspecting a bottle neck in your mainboard :)

In article <1088012966.1347.28.camel@solaris.skunkware.org> you wrote:
> PERC *megaraid* series and an Adaptec card *aacraid*) and have not been
> able to obtain more then 60MB/s doing hardware raid 5.

Is that peak or saturated load? you may want to try to only fill the write
back cache of the controller, to not get affected by slow raidness or disks.

The raid5 is not very good in speeding up random reads or sequential writes.
Perhaps you want to try stripping on level 0.

> The raid cards
> I'm testing are quad channel ultra160's with a total of 8 10k 72GB
> ultra320 drives (2 per channel) per raid volume... thus I should be able
> to do a fairly large amount of I/O (100+MB sequential writes I'd
> assume).

What is the IO Bus you are talking about? Single PCI Bus?

Have you tried an alternative operating system?

> I have tried every possible striping configuration a long with multiple
> filesystem (ext2/3/xfs)

You may want to try it without a filesystem and perhaps even with a faster
raid configuration like stripping.

> Please confirm and if possible provide possible settings needed to get
> linux in the mode for high i/o or general places to tune I/O.

how does your vmstat and iostat look like? How many ram and cpu you are
talking about? is it an smp kernel?

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
