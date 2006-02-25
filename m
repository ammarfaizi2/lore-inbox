Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbWBYEAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbWBYEAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWBYEAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:00:10 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:54415 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932660AbWBYEAJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:00:09 -0500
X-ORBL: [68.252.239.198]
Message-ID: <43FFD641.6020104@gmail.com>
Date: Fri, 24 Feb 2006 22:00:01 -0600
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Wei Hu <glegoo@gmail.com>
CC: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Looking for a file monitor
References: <5be025980602232351k3f6182bbqed5ea54079193953@mail.gmail.com>	 <43FEBE83.6070700@gmail.com>	 <20060224130543.f5b46bcf.diegocg@gmail.com>	 <43FF3C1C.5040200@gmail.com> <5be025980602241640o84878ddy87fa8027b5cc6be5@mail.gmail.com>
In-Reply-To: <5be025980602241640o84878ddy87fa8027b5cc6be5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Hu wrote:
> Yeah, that's basically what I'm looking for.
> So is it correct that I can keep track of all the actions as inotify events?

Yes, you can. I just looked at the defn of sys_open and I see that 	
	fsnotify_open(f->f_dentry);
gets called, which internally calls:
	inotify_dentry_parent_queue_event(...) and,
	inotify_inode_queue_event(...)

Do check out inotify. The same applies to other generic operations on 
the VFS layer.

Hareesh
