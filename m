Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWBXRC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWBXRC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWBXRC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:02:28 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:47340 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932213AbWBXRC1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:02:27 -0500
X-ORBL: [68.252.239.198]
Message-ID: <43FF3C1C.5040200@gmail.com>
Date: Fri, 24 Feb 2006 11:02:20 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: glegoo@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Looking for a file monitor
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>	<43FEBE83.6070700@gmail.com> <20060224130543.f5b46bcf.diegocg@gmail.com>
In-Reply-To: <20060224130543.f5b46bcf.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Fri, 24 Feb 2006 02:06:27 -0600,
> Hareesh Nagarajan <hnagar2@gmail.com> escribió:
> 
> 
>> dnotify has been succeeded by inotify. check the link below:
>> 	http://www.kernel.org/pub/linux/kernel/people/rml/inotify/README
> 
> IIRC, inotify is not the best thing for examining system-wide events.
> Monitoring of directories is not recursive (neither it should, i think)
> so to examine the whole system you would need to need thousands of
> watches.

Surely.

But if we want to keep a track of all the files that are opened, read, 
written or deleted (much like filemon; ``Filemon's timestamping feature 
will show you precisely when every open, read, write or delete, happens, 
and its status column tells you the outcome."), we can write a simple 
patch that makes a note of these events on the VFS layer, and then we 
could export this information to userspace, via relayfs. It wouldn't be 
too hard to code a relatively efficient implementation.

Hareesh
