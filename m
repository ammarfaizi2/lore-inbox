Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261424AbSKLRBh>; Tue, 12 Nov 2002 12:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266600AbSKLRBh>; Tue, 12 Nov 2002 12:01:37 -0500
Received: from CPE-144-132-192-174.nsw.bigpond.net.au ([144.132.192.174]:17543
	"EHLO anakin.wychk.org") by vger.kernel.org with ESMTP
	id <S261424AbSKLRBg>; Tue, 12 Nov 2002 12:01:36 -0500
Date: Wed, 13 Nov 2002 00:53:09 +0800
From: Geoffrey Lee <glee@gnupilgrims.org>
To: ricci@trinityteam.it
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PDC20276 Linux driver
Message-ID: <20021112165309.GB12789@anakin.wychk.org>
References: <1037117166.8313.61.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.21.0211121649360.9631-100000@esentar.trinityteam.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0211121649360.9631-100000@esentar.trinityteam.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 04:53:20PM +0100, ricci@trinityteam.it wrote:
> 
> 
> On 12 Nov 2002, Alan Cox wrote:
> 
> > On Tue, 2002-11-12 at 15:43, ricci@trinityteam.it wrote:
> > > During Slackware installation (whith kernel compiled by myself), after
> > > about half a gigabyte written in the disk/disks all process
> > > reading/writeing from/to the disks stop running, I cannot kill them, ps
> > > show me them with the 'D' flag, I cannot umount the disk/disks.
> > 
> > What drives, exactly what messages are logged (dmesg) ?
> > 
> 
> About what message are u speaking about? Messages logged during boot, I
> can send u tomorrow (the computer is not here). After the hang no messages
> are logged.
> 
> 

FWIW, we seem to have a not-unsimilar problem.

Board is a Gigabyte GA-7VRXP which has an on-board Promise 20276.

For me:

Processes get stuck in D after a couple of days, and kernel log shows
an invalid NULL deference in find_inode() in fs/inode.c, when it does

inode->i_ino

dereference.

It does not check for whether inode is NULL or not.

I realize that appears to be valid, because it appears to me that inode
should never be NULL when it is retrieved from list_entry().

I have the ksymoops oops file available, I would be more than happy to
post that up if anyone wants to take a look.



	-- G.


-- 
char *p = "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b"
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd"
  "\x80\xe8\xdc\xff\xff\xff/bin/sh";


