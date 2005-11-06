Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVKFEkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVKFEkM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 23:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932286AbVKFEkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 23:40:12 -0500
Received: from verein.lst.de ([213.95.11.210]:50629 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932281AbVKFEkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 23:40:10 -0500
Date: Sun, 6 Nov 2005 05:39:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com, nathans@sgi.com,
       reiserfs-dev@namesys.com, zippel@linux-m68k.org, sfrench@samba.org,
       samba-technical@lists.samba.org
Subject: Re: [PATCH 10/25] fs: move ext2 ioctl32 handlers into file systems
Message-ID: <20051106043942.GA31343@lst.de>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162714.555612000@b551138y.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105162714.555612000@b551138y.boeblingen.de.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:27:00PM +0100, Arnd Bergmann wrote:
> The same ioctls (originally from ext2) are used on ext2, ext3,
> hfsplus, cifs, reiserfs and xfs. Since they are really compatible
> between 32 and 64 bit except for the ioctl number, the conversion
> handler is trivial and I copy it to each of these file systems
> in order to eventually get rid of fs/compat_ioctl.c completely.

NACK, this is completely idiotic.  Duplicating handlers is the very
last thing we want.  I actually have patches to move handling some
of those ioctls into generic code, but that's a different story.

