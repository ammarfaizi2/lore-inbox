Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbUDYTNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbUDYTNZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 15:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUDYTNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 15:13:25 -0400
Received: from the-village.bc.nu ([81.2.110.252]:12425 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261947AbUDYTNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 15:13:24 -0400
Subject: Re: [Linux-fbdev-devel] vesafb and *fb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
	 <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082906968.28039.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Sun, 25 Apr 2004 16:29:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-04-25 at 14:13, Geert Uytterhoeven wrote:
> > >     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> > > 	    printk(KERN_WARNING
> > > 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> > > 		    vesafb_fix.smem_start);
> > > 	    /* We cannot make this fatal. Sometimes this comes from magic
> > > 	       spaces our resource handlers simply don't know about */

Various built-in video systems broke on that test because we didnt
have resources for them so the resources couldnt be allocated. Probably
if vesafb is enabled we should skip any primary video device (ie the one
with VGA_EN at boot)

