Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUIJGBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUIJGBo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 02:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268250AbUIJGBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 02:01:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:14287 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268127AbUIJGBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 02:01:42 -0400
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: adaplas@pol.net
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200409101328.57431.adaplas@hotpop.com>
References: <1094783022.2667.106.camel@gaston>
	 <200409101328.57431.adaplas@hotpop.com>
Content-Type: text/plain
Message-Id: <1094796002.14398.118.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 16:00:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-10 at 15:28, Antonino A. Daplas wrote:

> If fb_get_options returns an error, drivers will not proceed with their
> initialization. The second method is more compatible with the
> previous setup semantics.
> 
> I told Geert that if the changes did bite us, then I have no choice
> but to add support for the second method.
> 
> So, if you think that the first method is not enough, then I will add the
> second method. Let me know.

I submited a patch moving offb to the bottom of the Makefile to at
least restore normal drivers. For ofonly, a bit more hackish, but
what about failing register_framebuffer for anything but offb ?

Ben.


