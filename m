Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270077AbTGNLYr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 07:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270096AbTGNLYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 07:24:47 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:7646 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270077AbTGNLYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 07:24:46 -0400
Date: Mon, 14 Jul 2003 12:39:21 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030714113921.GA5187@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Maneesh Soni <maneesh@in.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <20030714065116.GB1214@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714065116.GB1214@in.ibm.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 12:21:16PM +0530, Maneesh Soni wrote:
 > Can you add the following two points appended to the Generic VFS changes list?
 > 
 > Thanks
 > Maneesh

I had considered putting such things in there a while ago, but wanted
the doc to just let _users_ know what changes they should be aware of.
This sort of thing really belongs in a 2.5-api-changes.txt or the likes.
(Which I did ponder doing at one point, but time got the better of me).

		Dave


 > On Fri, Jul 11, 2003 at 02:04:59PM +0000, Dave Jones wrote:
 > [...]
 > > 
 > > Generic VFS changes.
 > > ~~~~~~~~~~~~~~~~~~~~
 > > - Since Linux 2.5.1 it is possible to atomically move a subtree to
 > >   another place. The call is...
 > >    mount --move olddir newdir
 > > - Since 2.5.43, dmask=value sets the umask applied to directories only.
 > >   The default is the umask of the current process.
 > >   The fmask=value sets the umask applied to regular files only.
 > >   Again, the default is the umask of the current process.
 >   - Since 2.5.62, dcache lookup is dcache_lock free. This does not affect
 >     normal filesystems as long as they follow proper dcache interfaces. Care
 >     should be taken (like holding per dentry lock) if one is racing with 
 >     d_lookup bringing a new dentry in dcache.
 >   - Since 2.5.75-bk1 onwards separate lock is used for vfsmounts instead of
 >     dcache_lock.
 >  
 > 
 > -- 
 > Maneesh Soni
 > IBM Linux Technology Center, 
 > IBM India Software Lab, Bangalore.
 > Phone: +91-80-5044999 email: maneesh@in.ibm.com
 > http://lse.sourceforge.net/
---end quoted text---
