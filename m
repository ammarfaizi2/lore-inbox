Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTGAPuT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 11:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbTGAPuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 11:50:19 -0400
Received: from law11-f60.law11.hotmail.com ([64.4.17.60]:42761 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262584AbTGAPuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 11:50:16 -0400
X-Originating-IP: [12.2.144.2]
X-Originating-Email: [mattreuther@hotmail.com]
From: "Matt Reuther" <mattreuther@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Date: Tue, 01 Jul 2003 12:04:37 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F60taFcFzr8cg00039319@hotmail.com>
X-OriginalArrivalTime: 01 Jul 2003 16:04:38.0411 (UTC) FILETIME=[7928A5B0:01C33FEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems like the loopback device would be useful for this. You can move all 
of you stuff into a mounted loopback device with the new fs. Is there not 
some utility to take a filesystem image from inside an fs, and overwrite 
that fs with it. It would be lots of sector-to-sector shuffling, but it 
would be cleaner than trying to convert.

I guess you could try overlaying the old and new filesystems by virtualizing 
the inodes, superblocks, directories, and other stuff in RAM, but you still 
have to write it to disk, and some of the metadata from one fs will collide 
with the other one. The superblock for ext2fs needs to written to several 
fixed places on the filesystem, which might also be needed by 
reiserfs/xfs/whatever.

Matt

_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE*.  
http://join.msn.com/?page=features/virus

