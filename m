Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUJaXfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUJaXfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbUJaXfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:35:18 -0500
Received: from bristol.swissdisk.com ([65.207.35.130]:7093 "EHLO
	bristol.swissdisk.com") by vger.kernel.org with ESMTP
	id S261694AbUJaXfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:35:11 -0500
Date: Sun, 31 Oct 2004 17:04:20 -0500
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] ieee1394 cleanup
Message-ID: <20041031220420.GA15424@phunnypharm.org>
References: <20041031213250.GD2495@stusta.de> <20041031212858.GC9684@phunnypharm.org> <20041031232954.GG2495@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031232954.GG2495@stusta.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 12:29:54AM +0100, Adrian Bunk wrote:
> On Sun, Oct 31, 2004 at 04:28:58PM -0500, Ben Collins wrote:
> 
> > Need to leave the csr1212 files alone. csr1212.[ch] is used for userspace
> > and kernelspace, and I don't want to have two versions.
> 
> But in this case, these functions don't have to be EXPORT_SYMBOL'ed?

That's true, but the files themselves need to be left intact.

> And besides this, they are global functions meaning that although they 
> are never used inside the kernel, they need space for every user of 
> FireWire.
> 
> What about wrapping them inside #ifndef __KERNEL__ ?

They may be used, and I don't want to worry about someone using the
function later on in the kernel, and have to trace down that it isn't
defined in the kernel build. The exports can be killed (since it isn't
likely to be used outside the scope of the ieee1394.ko module anyway).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
