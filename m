Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262513AbTDAN1M>; Tue, 1 Apr 2003 08:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbTDAN1M>; Tue, 1 Apr 2003 08:27:12 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:60097 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262513AbTDAN1L>; Tue, 1 Apr 2003 08:27:11 -0500
From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
To: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Reply-To: tomlins@cam.org
Date: Tue, 01 Apr 2003 08:38:32 -0500
References: <fa.eagpkml.m3elbd@ifi.uio.no>
Organization: me
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20030401133833.6C71DF3D@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT wrote:

> I believe the patch below will apply to both the above (I know it does
> to 2.5.66 and 2.4.20-pre2 mm/shmem.c does not look any different so it
> should be fine. :)
> 
> Anyways, what this patch does is allow you to specify the max amount of
> memory tmpfs can use as a percentage of available real ram. This (in my
> eyes) is useful so that you do not have to remember to change the
> setting if you want something other then 50% and some of your ram does
> (and you can't replacew it immediately).
> 
> Usage of this option is as follows:
> 
> tmpfs      /dev/shm tmpfs  rw,size=63%,noauto            0 0
> 
> This is taken from my working system and sets the tmpfs size to 63% of
> my real RAM (256MB). The end result is:
> 
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/shm/tmp            160868      6776    154092   5% /tmp
> 
> I've also tested remounting to silly values (and sane ones) and it all
> works fine with no oopses or freezes and the correct values appearing
> in df.
> 
> All up I feel safer using this then a hard value.

What does tmpfs have to do with ram size?  Its swappable.  This _might_ be
useful for ramfs but for tmpfs, IMHO, its not a good idea.

Ed Tomlinson

