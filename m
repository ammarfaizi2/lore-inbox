Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272521AbTHPPKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHPPKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:10:05 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:44457 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S272521AbTHPPKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:10:01 -0400
Date: Sat, 16 Aug 2003 17:09:58 +0200
From: Kurt Roeckx <Q@ping.be>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with framebuffer in 2.6.0-test3
Message-ID: <20030816150958.GA167@ping.be>
References: <20030815224652.GA335@ping.be> <Pine.LNX.4.44.0308152348071.30952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308152348071.30952-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 11:59:11PM +0100, James Simmons wrote:
> 
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o(.text+0x742cb): In function `tdfxfb_imageblit':
> > : undefined reference to `cfb_imageblit'
> > make: *** [.tmp_vmlinux1] Error 1
> 
> ??? That shouldn't happen.

I changed drivers/video/Makefile like this:

-obj-$(CONFIG_FB_3DFX)             += tdfxfb.o
+obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o

And now it works.


Kurt

