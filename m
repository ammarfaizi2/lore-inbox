Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265706AbUHOKg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265706AbUHOKg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 06:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUHOKg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 06:36:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61411 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265706AbUHOKgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 06:36:25 -0400
Date: Sun, 15 Aug 2004 11:36:24 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040815103624.GE12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150009.45034.gene.heskett@verizon.net> <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk> <200408150550.26476.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408150550.26476.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 05:50:26AM -0400, Gene Heskett wrote:
> fs/buffer.c: In function `remove_inode_buffers':
> fs/buffer.c:1079: warning: ISO C90 forbids mixed declarations and code
> ----------
> Do we need to address this?  Its a line immediately below the BUG-ON 
> patch that Marcelo had me put in most recently, and has probably been 
> there all along.

No, it had appeared when Marcelo had put BUG_ON() before a declaration
of local variable.  Not acceptable for merge into the tree, but OK for
a debugging patch.
