Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUFWVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUFWVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUFWVTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:19:48 -0400
Received: from quechua.inka.de ([193.197.184.2]:23987 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S266700AbUFWVQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:16:42 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: I/O Confirmation/Problem under 2.6/2.4
Organization: Deban GNU/Linux Homesite
In-Reply-To: <1088019818.1614.33.camel@solaris.skunkware.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BdF6k-0001gL-00@calista.eckenfels.6bone.ka-ip.net>
Date: Wed, 23 Jun 2004 23:16:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1088019818.1614.33.camel@solaris.skunkware.org> you wrote:
>> The raid5 is not very good in speeding up random reads or sequential writes.
>> Perhaps you want to try stripping on level 0.
>> 
> We need the data integrity and the storage so 0/1 isn't an option and 0
> definantly isn't.

sure but it helps to find out if it is a limitation of the raid controller,
the disk, pci or linux. first do a cache read, then a raid0 read and then
start to wonder about redundancy.

>> Have you tried an alternative operating system?
> I've tried Red Hat AS 3 and Gentoo 2004.1

Well, i was more refering to Windows :)

> Have actually done both for tests.  writing to the device w/o FS returns
> about the same rate.  Raid 0 is a bit faster then 5, but not by more
> then a couple of MB.

This clearly shows you, that the raid controller or disk is the problem.
(However of course this can also mean the driver is not using the best
controller mode)

Perhaps using 2 x PercDC is better here.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
