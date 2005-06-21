Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFUOMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFUOMT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 10:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVFUOJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 10:09:22 -0400
Received: from galileo.bork.org ([134.117.69.57]:22983 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261836AbVFUOIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 10:08:34 -0400
Date: Tue, 21 Jun 2005 10:08:31 -0400
From: Martin Hicks <mort@wildopensource.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050621140831.GQ29510@localhost>
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Jun 20, 2005 at 11:54:58PM -0700, Andrew Morton wrote:
> 
> vm-early-zone-reclaim
> 
>     Needs some convincing benchmark numbers to back it up.  Otherwise OK.

The only benchmarks I have for this were included in my last mail to
linux-mm:

http://marc.theaimsgroup.com/?l=linux-mm&m=111763597218177&w=2

Are they convincing?  Well, the patch doesn't seem to make the memory
thrashing case much worse ("make -j" kernbench run) which is a good
thing since the VM is trying to reclaim much earlier.

In the same e-mail I mention that there is a fairly good performance
gain in the optimal case, where processes are tied to a single node and
the node's memory is filled with page cache.  With zone reclaim turned
on the "make -j8" kernel build runs in 700 seconds;  735 seconds with
no reclaim.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
