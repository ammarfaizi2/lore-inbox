Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbTCGSAB>; Fri, 7 Mar 2003 13:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbTCGSAB>; Fri, 7 Mar 2003 13:00:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261713AbTCGSAA>;
	Fri, 7 Mar 2003 13:00:00 -0500
Date: Fri, 7 Mar 2003 10:08:49 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] ntfs OOPS (2.5.63)
Message-Id: <20030307100849.7afb53ae.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.30.0303071818080.32-100000@divine.city.tvnet.hu>
References: <20030307091720.6b71268c.rddunlap@osdl.org>
	<Pine.LNX.4.30.0303071818080.32-100000@divine.city.tvnet.hu>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Mar 2003 18:56:41 +0100 (MET) Szakacsits Szabolcs <szaka@sienet.hu> wrote:

| 
| On Fri, 7 Mar 2003, Randy.Dunlap wrote:
| 
| > BTW, I think that this would be a reasonable reason (huh?) to dismiss
| > this bug against NTFS -- i.e., if it's found to be a problem in general
| > kernel debug helpers.  Still be nice to find where it happened,
| > of course.
| 
| It seems (and CONFIG_DEBUG_SPINLOCK also seems to contribute)
|         init_MUTEX(&ni->mrec_lock);
| 	        ...
| 		INIT_LIST_HEAD(...)
| 
| and IMHO that shouldn't happen :) But you have the infamous 2.96
| compiler, there were several updates for Red Hat [remember how buggy
| code it complied?] but I don't know how many updates were issued for
| Mandrake and if you did those. gcc 3.2.2 generates much nicer code for
| __ntfs_init_inode.

OK, I'm fine with closing it as not an NTFS issue or as a tools issue
or something along those lines.

Thanks for looking into this.
--
~Randy
