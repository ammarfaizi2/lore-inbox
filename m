Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUKMVaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUKMVaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 16:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbUKMVaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 16:30:11 -0500
Received: from smtp-out.hotpop.com ([38.113.3.51]:39375 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261172AbUKMVaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 16:30:05 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Linus Torvalds <torvalds@osdl.org>, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sun, 14 Nov 2004 05:29:46 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Guido Guenther <agx@sigxcpu.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org> <200411132000.31465.adaplas@hotpop.com> <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411140529.48977.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 November 2004 02:00, Linus Torvalds wrote:
> On Sat, 13 Nov 2004, Antonino A. Daplas wrote:
> > Why not use in_be* and out_be* for __raw_read and raw_write?
>
> Please don't start using some stupid magic ppc-specific macros for a
> driver that has no reason to be PPC-specific. It then only causes bugs
> that show on one platform and not another.

I'm not. I'm just wondering that if the other approach was taken (keep the
hardware in little endian mode), then the write/read* macros, which are just
wrappers for in_le*/out_le*, would have been used. Would it help fix (or
cover up) bugs that are in PPC but not x86? 

Tony 



