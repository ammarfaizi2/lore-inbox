Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVD2N0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVD2N0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVD2N0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:26:43 -0400
Received: from fsmlabs.com ([168.103.115.128]:8619 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262610AbVD2NUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:20:47 -0400
Date: Fri, 29 Apr 2005 07:23:03 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alexander Nyberg <alexn@dsv.su.se>
cc: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>,
       Linux Kernel <linux-kernel@vger.kernel.org>, rnl@rnl.ist.utl.pt
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
In-Reply-To: <1114779578.497.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0504290721230.30771@montezuma.fsmlabs.com>
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt>
 <1114779578.497.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005, Alexander Nyberg wrote:

> > We've made some changes on our ftp server, and since that it's been crashing 
> > frequently (everyday) with a kernel panic. 
> > 
> > We've configured the 5 IDE 160GB drives into md raid5 arrays with LVM on top 
> > of that. All filesystems are reiserfs. The other change we made to the server 
> > was changing from a patched 2.6.10-ac12 kernel into a newer 2.6.11.7.
> > 
> > Not being able to see the whole stacktrace on screen, we've started a 
> > netconsole to investigate. Started the server and loaded it pretty bad with 
> > rsyncs and such... until it crashed after just 20 minutes.
> > 
> > The netconsole log was surprising - "kernel BUG at kernel/sched.c:2634!"
> > 
> > Any help would be GREATLY appreciated.
> > 
> 
> 
> 5 IDE disks into one MD raid5 into one LVM volume with reiserfs on top
> of it? Could you give me some way to reproduce the specific load you put
> on the machine plus your .config and I'll see what I can do.

Could you also try without CONFIG_4KSTACKS?

Thanks,
	Zwane

