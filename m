Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270546AbTGNGlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 02:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270548AbTGNGlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 02:41:50 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13767 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270546AbTGNGlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 02:41:49 -0400
Date: Mon, 14 Jul 2003 12:21:16 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030714065116.GB1214@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030711140219.GB16433@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711140219.GB16433@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

Can you add the following two points appended to the Generic VFS changes list?

Thanks
Maneesh

On Fri, Jul 11, 2003 at 02:04:59PM +0000, Dave Jones wrote:
[...]
> 
> Generic VFS changes.
> ~~~~~~~~~~~~~~~~~~~~
> - Since Linux 2.5.1 it is possible to atomically move a subtree to
>   another place. The call is...
>    mount --move olddir newdir
> - Since 2.5.43, dmask=value sets the umask applied to directories only.
>   The default is the umask of the current process.
>   The fmask=value sets the umask applied to regular files only.
>   Again, the default is the umask of the current process.
  - Since 2.5.62, dcache lookup is dcache_lock free. This does not affect
    normal filesystems as long as they follow proper dcache interfaces. Care
    should be taken (like holding per dentry lock) if one is racing with 
    d_lookup bringing a new dentry in dcache.
  - Since 2.5.75-bk1 onwards separate lock is used for vfsmounts instead of
    dcache_lock.
 

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
