Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRHFDyL>; Sun, 5 Aug 2001 23:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266606AbRHFDyB>; Sun, 5 Aug 2001 23:54:01 -0400
Received: from ppp43.ts5-2.NewportNews.visi.net ([209.8.198.107]:34804 "EHLO
	blimpo.internal.net") by vger.kernel.org with ESMTP
	id <S266582AbRHFDxq>; Sun, 5 Aug 2001 23:53:46 -0400
Date: Sun, 5 Aug 2001 23:53:43 -0400
From: Ben Collins <bcollins@debian.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: drivers/ieee1394 duplicate symbol, 2.4.8-pre4
Message-ID: <20010805235343.S30381@visi.net>
In-Reply-To: <32414.997069600@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <32414.997069600@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Aug 06, 2001 at 01:46:40PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 01:46:40PM +1000, Keith Owens wrote:
> drivers/ieee1394/raw1394.c:spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
> drivers/ieee1394/nodemgr.c:spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
> 
> when both raw1394 and nodemgr are linked into vmlinux, it gets
> 
> drivers/ieee1394/raw1394.o(.data+0x8): multiple definition of `host_info_lock'
> drivers/ieee1394/ieee1394.o(.data+0x8c): first defined here
> 
> Either host_info_lock should be static or it should be defined as
> extern in one source and referenced in the others.

It should be static. Thanks for the report. I believe this is fixed in
CVS, and if not, it will be soon.

Hopefully we'll get a chance to sync CVS to Linus before 2.4.8 final. If
not, I'll submit a patch for that bug atleast.

-- 
 .----------=======-=-======-=========-----------=====------------=-=-----.
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
