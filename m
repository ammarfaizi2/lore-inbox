Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbSJCKJm>; Thu, 3 Oct 2002 06:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263233AbSJCKJl>; Thu, 3 Oct 2002 06:09:41 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:47493 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S263232AbSJCKJk> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 06:09:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: AARGH! Please help. IDE controller fsckup
Date: Thu, 3 Oct 2002 12:25:11 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210021516.46668.roy@karlsbakk.net> <20021003095316.GC7350@unthought.net>
In-Reply-To: <20021003095316.GC7350@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210031225.11283.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > so - now - the CMD649 has suddenly begun to fail - losing contact with
> > one or two drives, and I _really_ need to get what's on /data (RAID-5 on
> > hd[efghijklmnop]) out. Problem is - the replacement controller I've got
> > from the vendor works fine (turns up as controller 3 serving hd[mnop]).
> > How can I revert this most easily to be able to boot again?
>
> Hindsight:  had you used persistent superblocks, this would not have
> been a problem.  The kernel would know the correct ordering from the
> superblocks, not the device names.

I have used presistent superblocks, but md0,1,2,3 will be differently ordered 
if I change the disk order... At least I think so. It surely didn't work.

> Solution 1: Write to the RAID mailing list and have one of the mdadm
> gurus give you a one-liner to initialize the array with the proper
> ordering.
>
> Solution 2: Edit your /etc/raidtab to reflect the new device naming and
> run raidstart.

ok. but this won't be neccecary with persistent superblocks? right?

> If you start up the array with a bad ordering, no amount of magic is
> going to bring back you data (after parity has been "reconstructed" on
> various chunks of your existing data).

But ... with persistent superblock - is it possible to fsckup the raid?

> linux-raid is a better place.

I'll mail them. Thanks anyway

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

