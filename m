Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbTCGRzO>; Fri, 7 Mar 2003 12:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbTCGRzO>; Fri, 7 Mar 2003 12:55:14 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:19986 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S261692AbTCGRzN>; Fri, 7 Mar 2003 12:55:13 -0500
Date: Fri, 7 Mar 2003 18:56:41 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: <aia21@cantab.net>, <linux-kernel@vger.kernel.org>,
       <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
In-Reply-To: <20030307091720.6b71268c.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.30.0303071818080.32-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Mar 2003, Randy.Dunlap wrote:

> BTW, I think that this would be a reasonable reason (huh?) to dismiss
> this bug against NTFS -- i.e., if it's found to be a problem in general
> kernel debug helpers.  Still be nice to find where it happened,
> of course.

It seems (and CONFIG_DEBUG_SPINLOCK also seems to contribute)
        init_MUTEX(&ni->mrec_lock);
	        ...
		INIT_LIST_HEAD(...)

and IMHO that shouldn't happen :) But you have the infamous 2.96
compiler, there were several updates for Red Hat [remember how buggy
code it complied?] but I don't know how many updates were issued for
Mandrake and if you did those. gcc 3.2.2 generates much nicer code for
__ntfs_init_inode.

	Szaka

