Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVIRRbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVIRRbD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVIRRbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:31:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:19661 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932083AbVIRRbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:31:01 -0400
Date: Sun, 18 Sep 2005 18:30:58 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918173058.GM19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127041474.8932.4.camel@localhost.localdomain> <20050918143907.GK19626@ftp.linux.org.uk> <200509181925.25112.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509181925.25112.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 07:25:24PM +0300, Denis Vlasenko wrote:
> Do these qualify?
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0105.1/0579.html
> o Fix wrong kmalloc sizes in ixj/emu10k1 (David Chan) 

ixj does, emu10k does not (sizeof(p) instead of sizeof(*p) would be
exact same bug).
 
> http://www.mail-archive.com/alsa-cvslog@lists.sourceforge.net/msg02483.html
> Update of /cvsroot/alsa/alsa-kernel/isa
> In directory sc8-pr-cvs1:/tmp/cvs-serv4034
> 
> Modified Files:
>         es18xx.c cmi8330.c 
> Log Message:
> Fixed wrong kmalloc

Nope.  Wrong order of arguments in kmalloc; nothing to do with what we
intend to pass as size.
