Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264654AbTAJIxp>; Fri, 10 Jan 2003 03:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbTAJIxo>; Fri, 10 Jan 2003 03:53:44 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:51460 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264654AbTAJIxn>; Fri, 10 Jan 2003 03:53:43 -0500
Message-Id: <200301100855.h0A8t5s15225@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
Date: Fri, 10 Jan 2003 10:54:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew McGregor <andrew@indranet.co.nz>, eric@andante.org,
       linux-kernel@vger.kernel.org
References: <15902.14667.489252.346007@wombat.chubb.wattle.id.au> <200301100634.h0A6Yps14454@Port.imtp.ilyichevsk.odessa.ua> <15902.35492.536040.298566@wombat.chubb.wattle.id.au>
In-Reply-To: <15902.35492.536040.298566@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 10:56, Peter Chubb wrote:
> >>>>> "Denis" == Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
> >>>>> writes:
>
> Denis> On 10 January 2003 05:34, Peter Chubb wrote:
> >> Preferably, all the inumbers for the same file would point to the
> >> same directory entry; but I can see no easy way to do that.
> >> Keeping an in-memory table for files with multiple links might be
> >> the best way, as there aren't that many on a typical filesystem.
>
> Denis> And what will happen on a non-typical filesystem with 1
> million Denis> hardlinks?
>
> Denis> The root of the problem is a fundamental layering violation in
> Denis> traditional Unix filesystems: inode numbers should NOT be
> Denis> visible to userspace. Userspace just needs a way to tell
> Denis> hardlinks from separate files, that's all. Exposing inumbers
> Denis> does that, but creates tons of problems for filesystems which
> Denis> do NOT have such a concept.
>
> The problem is that in Unix the fundamental identity of a file is
> the tuple (blkdev, inum); names are merely indices (links) that
> resolve to that tuple.

You are right. It is designed this way. This design is wrong.

> Personally, I'd swap to a pair of system
> calls to map name to (blkdev, inum), and open(blkdev, inum).  Think
> of the inode number as a unique within-filesystem index.

This does not fix the design.
--
vda
