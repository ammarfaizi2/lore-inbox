Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbREXWs1>; Thu, 24 May 2001 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262470AbREXWsQ>; Thu, 24 May 2001 18:48:16 -0400
Received: from [195.211.46.202] ([195.211.46.202]:20794 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S262468AbREXWsE>;
	Thu, 24 May 2001 18:48:04 -0400
Date: Thu, 24 May 2001 09:31:49 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: Dave Mielke <dave@mielke.cc>
Cc: "Linux Kernel (mailing list)" <linux-kernel@vger.kernel.org>
Subject: Re: nfs mount by label not working.
In-Reply-To: <Pine.LNX.4.30.0105231505330.995-100000@dave.private.mielke.cc>
Message-ID: <Pine.LNX.4.33.0105240922390.5852-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2001, Dave Mielke wrote:

> Using kernel 2.2.17-14 as supplied by RedHat, and using mount from
> mount-2.9u-4, mounting by label using the -L option does not work.
>
>     mount -L backup1 /a
Do you realy mean what you wrote in the Subject line:

Subject : Re: *nfs* mount by label not working.
              ^^^^^

That would be something like:
   ask every server in the known universe if it has a nfs-export by
   name backup1, choose one of them and mount it locally on /a.

If you use nfs you have to specify the server and the volume old
fashioned. Mounting by lable or uuid is supported by very few filesystems,
mainly by ext2 only.

What the kernel does is to read /proc/partitions and check if any
partition found there has the label or uuid you search for.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

