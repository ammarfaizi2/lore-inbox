Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRLFSvM>; Thu, 6 Dec 2001 13:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282498AbRLFSvC>; Thu, 6 Dec 2001 13:51:02 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:43503 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S282067AbRLFSuo>; Thu, 6 Dec 2001 13:50:44 -0500
Date: Thu, 6 Dec 2001 18:50:27 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steffen Persvold <sp@scali.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        nfs list <nfs@lists.sourceforge.net>, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: 2.4.9 kernel crash
Message-ID: <20011206185027.O2029@redhat.com>
In-Reply-To: <3C077FF8.AFBD8DB8@scali.no> <3C07E905.DF30E497@zip.com.au> <20011204003350.L2857@redhat.com> <3C0FB84A.76D8C003@scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0FB84A.76D8C003@scali.no>; from sp@scali.no on Thu, Dec 06, 2001 at 07:26:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 06, 2001 at 07:26:18PM +0100, Steffen Persvold wrote:

> So what could this be then ?
 
> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

This one is a little unfamiliary, but the oops:

> Call Trace: [<c0150eb6>] prune_dcache [kernel] 0xf6 
> [<c01357a5>] page_launder [kernel] 0x8f5 
> [<c01512a1>] shrink_dcache_memory [kernel] 0x21 
> [<c0135bab>] do_try_to_free_pages [kernel] 0x1b 
> [<c0135c35>] kswapd [kernel] 0x55 
> [<c0105000>] stext [kernel] 0x0 
> [<c0105866>] kernel_thread [kernel] 0x26 
> [<c0135be0>] kswapd [kernel] 0x0 

has been reported before, even on much more recent kernels, and even
without ext3 loaded.  So basically I've no idea what's behind it.

Cheers,
 Stephen
