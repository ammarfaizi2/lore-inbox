Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSJ2UEP>; Tue, 29 Oct 2002 15:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJ2UEO>; Tue, 29 Oct 2002 15:04:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:26056 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262317AbSJ2UEN>;
	Tue, 29 Oct 2002 15:04:13 -0500
Date: Tue, 29 Oct 2002 20:08:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK updates] fbdev changes updates.
Message-ID: <20021029200838.GA27552@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.33.0210291240170.14451-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0210291240170.14451-100000@maxwell.earthlink.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2002 at 12:45:10PM -0800, James Simmons wrote:
 > The reason for this is we will see in the future embedded ix86
 > boards with things like i810 framebuffers with NO vga core. In this case
 > we will need a fbdev driver for a graphical console. Thus the agp code
 > must be started before the fbdev layer.

Can you explain exactly what the agpgart code is doing that needs
to be done earlier than framebuffer ? I don't see any reason for this
change. There should be no GART mappings until we've booted userspace
(except for the case of IOMMU)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
