Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318204AbSHMQIG>; Tue, 13 Aug 2002 12:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318208AbSHMQIG>; Tue, 13 Aug 2002 12:08:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43013 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318204AbSHMQIE>; Tue, 13 Aug 2002 12:08:04 -0400
Date: Tue, 13 Aug 2002 09:13:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - part 2 of 3
In-Reply-To: <200208131705.MAA02410@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0208130912390.7291-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Jeff Dike wrote:
>
> This patch contains the remaining unmerged change to generic code that UML 
> needs.  It adds boot entries for the UML block device.

I absolutely detest the array in do_mounts, and I detest it even more when 
somebody adds a gazillion new entries to it.

Please use "root=0xXXYY" instead, or consider figuring out the name 
_automatically_ from the list of genhd's in the system (ie the reverse of 
blkdev_name() or whatever it is called).

		Linus

