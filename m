Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263649AbRFFSVo>; Wed, 6 Jun 2001 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263994AbRFFSVe>; Wed, 6 Jun 2001 14:21:34 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:42591 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263649AbRFFSVY>; Wed, 6 Jun 2001 14:21:24 -0400
Date: Wed, 6 Jun 2001 19:20:13 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, viro@math.psu.edu,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: mount --bind accounting
Message-ID: <20010606192013.B3761@redhat.com>
In-Reply-To: <UTC200106032038.WAA184171.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200106032038.WAA184171.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Jun 03, 2001 at 10:38:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 03, 2001 at 10:38:29PM +0200, Andries.Brouwer@cwi.nl wrote:

> Each bind does an alloc_vfsmnt() and hence takes some kernel memory.
> Any user can therefore take all kernel memory, until
> 	kmalloc(sizeof(struct vfsmount), GFP_KERNEL)
> fails. Bad security.

Until we can account properly for basic things like page tables, the
small kmallocs for things like vfsmount and file structs will be
negligible in comparison.

Fortunately we used to have at least skeleton patches for a framework
in which to do this.  Whatever happened to beancounter, anyway?  Is
somebody maintaining that at all these days?

Cheers,
 Stephen
