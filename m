Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCAWSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbUCAWSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:18:04 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:6289 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261457AbUCAWQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:16:19 -0500
Date: Mon, 1 Mar 2004 23:16:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] kbuild: Add a binary only .o file to a module
Message-ID: <20040301221658.GA8187@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20040301214617.GA7777@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040301214617.GA7777@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2004 at 10:46:17PM +0100, Sam Ravnborg wrote:
> 
> This can be done in several other ways as already suggested in on lkml.
> But none of them were what I consider 'good enough' - introducing
> some spooky rules etc.

Forget it - I realised this is already supported by kbuild in a nice way.
The _shipped functionality can be used here, so the RTL8180 Makefile
now looks like this:

EXTRA_CFLAGS = -DRTL_IO_MAP

obj-m		:= rtl8180.o
rtl8180-y	+= r8180_if.o r8180_pci_init.o usercopy.o
rtl8180-y	+= priv_part.o

And the binary only .o file is named priv_part.o_shipped.

No added complexity to kbuild - but I need to document this somewhere...

	Sam
