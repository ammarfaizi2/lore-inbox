Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWAIRUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWAIRUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAIRUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:20:02 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15111 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751300AbWAIRUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:20:00 -0500
Date: Mon, 9 Jan 2006 18:19:38 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109171938.GA19283@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109164611.GA1382@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:46:11PM +0000, Christoph Hellwig wrote:
> On Mon, Jan 09, 2006 at 05:42:14PM +0100, Sam Ravnborg wrote:
> > Hi hch.
> > 
> > Any specific reason why xfs uses a indirection for the Makefile?
> > It is planned to drop export of VERSION, PATCHLEVEL etc. from
> > main makefile and it is OK except for xfs due to the funny
> > Makefile indirection.
> > 
> > I suggest:
> > git mv fs/xfs/Makefile-linux-2.6 fs/xfs/Makefile
> 
> I'd be all for it, but the SGI people like this layout to keep a common
> fs/xfs for both 2.4 and 2.6 (with linux-2.4 and linux-2.6 subdirs respectively)
> 
I have the following in my tree right now to make it compile.
But it looks pointless to me. All other submitters are asked to keep
backward compatibility cruft out of kernel proper - the same should
hold for xfs.

	Sam

diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
index 49e3e7e..0630339 100644
--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -1 +1 @@
-include $(TOPDIR)/fs/xfs/Makefile-linux-$(VERSION).$(PATCHLEVEL)
+include $(srctree)/fs/xfs/Makefile-linux-2.6

