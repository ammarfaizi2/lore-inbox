Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUGFT4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUGFT4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 15:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUGFT4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 15:56:03 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1706 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261236AbUGFT4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 15:56:00 -0400
Date: Tue, 6 Jul 2004 14:58:16 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: FabF <fabian.frederick@skynet.be>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] f_pos ?
Message-ID: <20040706195816.GB3097@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1088968685.2429.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088968685.2429.1.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 07:31:29PM +0000, FabF wrote:
> Hi,
> 	
> 	I try to understand how readdir process works and I can't understand
> f_pos management :
> 
>         Having in mind things work that way :
> 
>         user : ls
>         glibc : 
>                 open (->sys_open)
>                 getdentries64 (->sys_getdentries64)
>                 
>         kernel:
>                 sys_getdentries64
>                 ->vfs_readdir
>                         ->ext2_readdir
> 
> At that point, I don't understand why ext2_readdir is playing with
> filp->f_pos .... It should be 0 ...Why does it care about offset ?
> 

I think it may not be 0 all the time. A seekdir() could change could change
the offset to non-zero.

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM Austin
email: maneesh@in.ibm.com
Phone: 1-512-838-1896 Fax: 
T/L : 6781896
