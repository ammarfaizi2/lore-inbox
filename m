Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270760AbTHANzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 09:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270762AbTHANzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 09:55:47 -0400
Received: from tolkor.SGI.COM ([198.149.18.6]:58035 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S270760AbTHANzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 09:55:44 -0400
Subject: Re: xfs problems (2.6.0-test2)
From: Steve Lord <lord@sgi.com>
To: Jose Luis Alarcon <jlalarcon@chevy.zzn.com>
Cc: Nathan Scott <nathans@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <F759403221D30FB40B5B2C15610E4950@jlalarcon.chevy.zzn.com>
References: <F759403221D30FB40B5B2C15610E4950@jlalarcon.chevy.zzn.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059746139.7842.10.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Aug 2003 08:55:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-01 at 02:58, Jose Luis Alarcon wrote:
> >
> >Hi there,
> >
> >What XFS blocksize are you using, and what is your page size?
> >There are known issues when using blocksizes smaller than the
> >page size in the 2.6 XFS code at the moment.
> >
> 
>   Hi Nathan, and congratilations for the SGI work.
> 
>   Now i have a Mandrake with the 2.5.75 kernel and XFS in
> all partitions. The filesystem looks work very well.
> 
>   I am planning install 2.6.0-test3 when it comes and i wanna
> ask you: how can i know what blocksize am i using?, and how
> know what is the page size in my system?.
> 
>   Thanks you, very much, in advance.
> 
>   Regards.
> 
>   Jose.

Use the xfs_info command on a mount point:

meta-data=/xfs                   isize=256    agcount=8, agsize=131031
blks
         =                       sectsz=512  
data     =                       bsize=4096   blocks=1048241, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096  
log      =internal               bsize=4096   blocks=16384, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

bsize=4096 is the vlock size.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
