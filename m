Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266868AbTGGIWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 04:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266843AbTGGIWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 04:22:15 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3200 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266868AbTGGIV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 04:21:29 -0400
Date: Mon, 7 Jul 2003 09:43:51 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307070843.h678hp3V000376@81-2-122-30.bradfords.org.uk>
To: jesse@cats-chateau.net, linux-kernel@vger.kernel.org, mlmoser@comcast.net,
       svein.ove@aas.no, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: File System conversion -- ideas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What this boils down to is, "there may not be enough space".
> Personally I prefer incrementally resizing LVM partitions for conversion 
> anyway, but I'll take a stab at this.

Depending on the filesystem, incrementally resizing LVM paritions
could be a very _bad_ way to do it - continuously re-sizing a
partition will typically encourage poor layout and fragmentation.  It
would be possible to defragment and optimise the partition afterwards,
but that would extend the convertion time even more, especially if it
was done in a way which kept a consistent filesystem throughout, on a
filesystem without much free space.

The way to avoid, or at least minimise the problem of having one
partition filling the disk, is not to fully partition disks to begin
with - that gives you the flexibility to test and use different
partition types, and move data around.  Even without using LVM, it's
easy to move data around if it's on partitions which are each no
bigger than 25% of the disk.

John.
