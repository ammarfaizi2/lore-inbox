Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288696AbSANLk1>; Mon, 14 Jan 2002 06:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289209AbSANLkK>; Mon, 14 Jan 2002 06:40:10 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:54283 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288696AbSANLhZ>; Mon, 14 Jan 2002 06:37:25 -0500
Date: Mon, 14 Jan 2002 14:36:50 +0300
From: Oleg Drokin <green@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
        ewald.peiszer@gmx.at, matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020114143650.D828@namesys.com>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <3C42BE0E.2090902@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C42BE0E.2090902@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Jan 14, 2002 at 02:16:30PM +0300, Hans Reiser wrote:

> So what solution should we use, zeroing or fixing msdos to not try 
> something reiserfs can find, or both or what?

We can use both:
     destroy MSDOS superblock (if any) at mkreiserfs (or don't touch 1st block of the device if there is no
     msdos superblock).
     And link reiserfs code into the kernel earlier than msdos code is linked in.

This second way is for those poor souls who ran mkreiserfs on top of their FAT partitions before
we released new mkreiserfs that can destroy FAT superblocks.

> I want the solution to also fixes the error messages from msdos that it 
> issues when it sees reiserfs that are confusing for users.
Changing of linking order will fix that, too.

Bye,
    Oleg
