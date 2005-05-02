Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVEBWn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVEBWn0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 18:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVEBWn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 18:43:26 -0400
Received: from mail.tmr.com ([64.65.253.246]:51212 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261192AbVEBWnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 18:43:23 -0400
Date: Mon, 2 May 2005 18:30:03 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Grzegorz Kulewski <kangur@polcom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to flush data to disk reliably?
In-Reply-To: <1115070074.10338.53.camel@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1050502182749.28303A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2005, Alan Cox wrote:

> On Llu, 2005-05-02 at 20:18, Grzegorz Kulewski wrote:
> > What about other filesystems? Does anybody know anwser for Reiserfs3, 
> > Reiser4, JFS, XFS and any other popular server filesystems? I assume that 
> > if log file is some block device (like partition) both O_SYNC and fsync 
> > will work? What about ext2? What about some strange RAID/DM/NBD 
> > configurations? (I do not know in advance what our customers will use so I 
> > need portable method.)
> 
> RAID does stripe sized rewrites so you get into the same situation as
> with actual disks - a physical media failure might lose you old data
> (but then if the disk goes bang so does the data...)

I hope I'm reading that wrong, and that rewriting a single sector of a
file doesn't result in r-a-w of the entire stripe. That would be a large
memory hit for filesystems with large stripes for mostly sequential i/o.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

