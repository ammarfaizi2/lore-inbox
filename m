Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWAUIZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWAUIZE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWAUIZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:25:04 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:17544 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751157AbWAUIZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:25:01 -0500
Date: Sat, 21 Jan 2006 13:54:39 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ed Swierk <eswierk@cs.stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS: file-max limit reached when running on a virtual machine
Message-ID: <20060121082439.GA7277@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <loom.20060119T045624-92@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <loom.20060119T045624-92@post.gmane.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 04:19:24AM +0000, Ed Swierk wrote:
> I'm getting the error "VFS: file-max limit 50905 reached" on kernels 2.6.14 and
> 2.6.15, running on a qemu virtual machine configured with 512 MB of memory.  The
> I understand that changes have been made recently to the way the kernel manages
> file descriptors in order to improve real-time performance.

The file descriptor changes were done to make lookup in the fd table
lock-free there by improving thread scalability.

> Is there some other way to make the kernel less sensitive to ill-behaved
> hardware timers, as it was pre-2.6.14, assuming that I am willing to sacrifice
> real-time performance?
> 
> Any help would be appreciated.

Can you try this patch I posted a while ago -

http://marc.theaimsgroup.com/?l=linux-kernel&m=113657112726596&w=2

Thanks
Dipankar
