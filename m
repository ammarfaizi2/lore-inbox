Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWIYLEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWIYLEr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWIYLEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:04:47 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:34833 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751125AbWIYLEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:04:46 -0400
Date: Mon, 25 Sep 2006 12:04:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv
Message-ID: <20060925110437.GD25449@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <1159183568.11049.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159183568.11049.51.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 12:26:08PM +0100, Alan Cox wrote:
> Ar Llu, 2006-09-25 am 11:44 +0100, ysgrifennodd David Howells:
> > Al Viro <viro@ftp.linux.org.uk> wrote:
> > 
> > > +++ b/include/asm-frv/libata-portmap.h
> > > @@ -0,0 +1 @@
> > > +#include <asm-generic/libata-portmap.h>
> > 
> > NAK...  These settings are totally meaningless on FRV.
> 
> You have no PCI bus ?

Note that if you don't provide an asm/libata-portmap.h file, you can't
build libata at the moment - linux/libata.h requires this file to be
present.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
