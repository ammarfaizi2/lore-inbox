Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUHOXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUHOXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUHOXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:41:25 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:35067 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267258AbUHOXlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:41:12 -0400
Date: Mon, 16 Aug 2004 00:40:43 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040815133432.A1750@infradead.org>
Message-ID: <Pine.LNX.4.58.0408160038320.9944@skynet>
References: <Pine.LNX.4.58.0408151311340.27003@skynet> <20040815133432.A1750@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Aug 15, 2004 at 01:19:31PM +0100, Dave Airlie wrote:
> > Graphics, and the DRM now uses PCI properly if no framebuffer is loaded
> > (it falls back if framebuffer is enabled...),
>
> Can you explain what this means?
>

Probably should say PCI APIs properly, it now does enable/disable devices
and registers the DRM as owning the memory regions, does proper PCI
probing .. in cases where the fb is loaded on the card already it falls
back to the old ways (evil direct register writing.. ), this change will
stop you loading the fb driver adter the drm driver but this shouldn't be
a common case at all..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

