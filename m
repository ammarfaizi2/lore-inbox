Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbVCIVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbVCIVfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVCIVaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:30:23 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:58311 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262409AbVCIV0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:26:47 -0500
Date: Thu, 10 Mar 2005 02:57:32 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inode cache, dentry cache, buffer heads usage
Message-ID: <20050309212732.GA5036@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 10:55:58AM -0800, Badari Pulavarty wrote:
> Hi,
> 
> We have a 8-way P-III, 16GB RAM running 2.6.8-1. We use this as
> our server to keep source code, cscopes and do the builds.
> This machine seems to slow down over the time. One thing we
> keep noticing is it keeps running out of lowmem. Most of 
> the lowmem is used for ext3 inode cache + dentry cache +
> bufferheads + Buffers. So we did 2:2 split - but it improved
> thing, but again run into same issues.
> 
> So, why is these slab cache are not getting purged/shrinked even
> under memory pressure ? (I have seen lowmem as low as 6MB). What
> can I do to keep the machine healthy ?

How does /proc/sys/fs/dentry-state look when you run low on lowmem ?

Thanks
Dipankar
