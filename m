Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTANGeG>; Tue, 14 Jan 2003 01:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267469AbTANGeG>; Tue, 14 Jan 2003 01:34:06 -0500
Received: from packet.digeo.com ([12.110.80.53]:2536 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267468AbTANGeE> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 01:34:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Morton <akpm@digeo.com>
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: intense disk or tty activity SEGV's X
Date: Mon, 13 Jan 2003 22:43:31 -0800
User-Agent: KMail/1.4.3
References: <20030114063457.GA11073@kanoe.ludicrus.net>
In-Reply-To: <20030114063457.GA11073@kanoe.ludicrus.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301132243.31071.akpm@digeo.com>
X-OriginalArrivalTime: 14 Jan 2003 06:42:50.0419 (UTC) FILETIME=[283B4030:01C2BB98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon January 13 2003 22:34, Joshua M. Kwan wrote:
>
> Lately, using the nForce IDE driver I have noticed a few glitches with 
> it that affect stability.
> 
> I use the BK tree for my kernel source. Lately, if I 1) clone a fresh 
> tree (i pull from a few places so sometimes there are some boggling 
> conflicts that a fresh tree fixes) or 2) run a bk pull, X will SEGV out 
> of nowhere. At first I thought it was the amount of disk activity.
> 
> But after reading the saga of the flukey tty code in the kernel, I am 
> thinking this could also be because of that? Lots of stuff scrolls by 
> when doing a bk clone, and when resolve runs after a bk pull there is 
> often lots of output.
> 
> There is no oops at all, nor anything that might be of help in dmesg.
> Any ideas? I started noticing it around halfway through 2.5.56...
> 

You could just do something like

	while true
	do
		cat /usr/src/linux/MAINTAINERS
	done

and see if that kills it.  If so then yeah, it could be a tty thing.  If not
then it may be mm/fs/vm/harware related.  Confirm that by running
dbench/tiobench/etc.

Basically: separate it out, eliminate some variables.

The most valuable thing you can do is to narrow it down to a particular
changeset.



