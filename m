Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUHGOqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUHGOqR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 10:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUHGOqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 10:46:16 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:56844 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262730AbUHGOqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 10:46:13 -0400
Date: Sat, 7 Aug 2004 15:46:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Whitwell <keith@tungstengraphics.com>
Cc: Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
       Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
Message-ID: <20040807154600.B18510@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Ian Romanick <idr@us.ibm.com>, Jon Smirl <jonsmirl@yahoo.com>,
	Dave Airlie <airlied@linux.ie>,
	DRI developer's list <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040806024907.13024.qmail@web14923.mail.yahoo.com> <4113B2AE.8090706@us.ibm.com> <4113B7DC.6000000@tungstengraphics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4113B7DC.6000000@tungstengraphics.com>; from keith@tungstengraphics.com on Fri, Aug 06, 2004 at 05:54:52PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 05:54:52PM +0100, Keith Whitwell wrote:
> Yes, while I support the current rework and de-templatization of the code, I 
> don't support any attempt to split the drm modules to try and share code at 
> runtime - ie. I don't support a core/submodule approach.

We had that argument already in 2000/2001 when we had the big XFree 4.1 DRM
update.  There's no reason drm should be different from all other kernel
subsystems.  If you really fear this is a problem add a monotonely increasing
DRM_VERSION define for driver to check against and even better don't make any
not backwards-compatible changes unless you're doing a major version bump.

