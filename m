Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263315AbSJCM6C>; Thu, 3 Oct 2002 08:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbSJCM6B>; Thu, 3 Oct 2002 08:58:01 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:3718 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S263312AbSJCM57> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 08:57:59 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: AARGH! Please help. IDE controller fsckup
Date: Thu, 3 Oct 2002 15:13:28 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
References: <200210021516.46668.roy@karlsbakk.net> <200210031225.11283.roy@karlsbakk.net> <20021003114020.GD7350@unthought.net>
In-Reply-To: <20021003114020.GD7350@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210031513.28459.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have used presistent superblocks, but md0,1,2,3 will be differently
> > ordered if I change the disk order... At least I think so. It surely
> > didn't work.
>
> No. md0 would stay md0.  This is another effect of using superblocks,
> and in fact this is also (ironically) more or less the only argument
> *against* using them   :)
>
> (Imagine inserting a disk which knows that it is disk 0 of md0 into some
> machine that already has a perfectly fine md0 running)

ok. so. theoretically - as long as the system finds all 16 drives, I should be 
able to shuffle them around and attach them to whichever controller there is? 
right?

ok.

now, I've replaced the faulty controller, and booting up. the new controller 
is also (like the old one) a CMD649...

hæ?

it works. but it surely didn't work last time...

thanks

> > But ... with persistent superblock - is it possible to fsckup the raid?
>
> You're root, it is indeed possible  :)

er - yes. I more meant like 'automagically'

> But you would not need to perform any of the special operations that you
> need to now.
>
> Persistent superblocks saves you from a number of "bad" situations you
> can encounter with normal production systems (such as replacing a
> controller or moving disks around).
>
> One should be careful when moving disks with persistent superblocks
> between systems though. You don't want the kernel to autodetect the
> "wrong" md0 on boot   :)    I consider this problem nonexistent in the
> production environment that I administer, but I know that some people
> feel differently about it.  You should consider these pros and cons in
> relation to your environment and make a decision based on that.


-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

