Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbUCQWkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 17:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbUCQWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 17:40:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:49829 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262120AbUCQWkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 17:40:41 -0500
Date: Wed, 17 Mar 2004 14:40:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Alex Goddard <agoddard@purdue.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4, or what I still don't quite like about the new stable  
 branch
Message-Id: <20040317144038.533c9150@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.58.0403171709000.4288@dust.p68.rivermarket.wintek.com>
References: <S263158AbUCMS0h/20040313182637Z+893@vger.kernel.org>
	<Pine.LNX.4.58.0403131642270.4325@dust.p68.rivermarket.wintek.com>
	<4058097F.4070606@aitel.hist.no>
	<Pine.LNX.4.58.0403171709000.4288@dust.p68.rivermarket.wintek.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004 17:27:50 -0500 (EST)
Alex Goddard <agoddard@purdue.edu> wrote:

> On Wed, 17 Mar 2004, Helge Hafting wrote:
> 
> > Alex Goddard wrote:
> > [...]
> > > 
> > > Safe module unloading is a very difficult problem.  So much so that
> > > disallowing unloading modules completely has been discussed in the past.  
> > > Digging around an lkml archive for more info on why module unloading is
> > > inherently problematic, and not at all easy to do (well, not at all easy

The problem for must users of earlier versions of linux is the definition of
safe changed.  Safe now means you can remove the module without crashing
the kernel.  Safe used to mean that nothing could possible be using the code.
Sort of like difference between NFS hard and soft mount.

A bigger issue is that there seems to be a whole set of smaller distro's and
people who write their own startup scripts that became addicted to the old behaviour.

I wish all the distro's would get rid of explicit modprobe and rmmod's in startup
scripts.
