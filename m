Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUGFUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUGFUwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUGFUwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:52:43 -0400
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:7621 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264538AbUGFUvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:51:41 -0400
Subject: Re: [OFFTOPIC] f_pos ?
From: FabF <fabian.frederick@skynet.be>
To: maneesh@in.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040706195816.GB3097@in.ibm.com>
References: <1088968685.2429.1.camel@localhost.localdomain>
	 <20040706195816.GB3097@in.ibm.com>
Content-Type: text/plain
Message-Id: <1089147084.3691.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 06 Jul 2004 22:51:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 21:58, Maneesh Soni wrote:
> On Sun, Jul 04, 2004 at 07:31:29PM +0000, FabF wrote:
> > Hi,
> > 	
> > 	I try to understand how readdir process works and I can't understand
> > f_pos management :
> > 
> >         Having in mind things work that way :
> > 
> >         user : ls
> >         glibc : 
> >                 open (->sys_open)
> >                 getdentries64 (->sys_getdentries64)
> >                 
> >         kernel:
> >                 sys_getdentries64
> >                 ->vfs_readdir
> >                         ->ext2_readdir
> > 
> > At that point, I don't understand why ext2_readdir is playing with
> > filp->f_pos .... It should be 0 ...Why does it care about offset ?
> > 
> 
> I think it may not be 0 all the time. A seekdir() could change could change
> the offset to non-zero.
> 
btw, someone could tell why old ext2 readdir had "do the readahead"
feature ; current ext3 as well but new ext2 implementation doesn't ???

Regards,
FabF

> Thanks
> Maneesh

