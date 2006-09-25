Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWIYOUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWIYOUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 10:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWIYOUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 10:20:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9624 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932173AbWIYOUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 10:20:25 -0400
Date: Mon, 25 Sep 2006 15:20:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv
Message-ID: <20060925142016.GI29920@ftp.linux.org.uk>
References: <1159186771.11049.63.camel@localhost.localdomain> <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> <7276.1159186684@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7276.1159186684@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 01:18:04PM +0100, David Howells wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > Wrong these are PCI settings. Please read the PCI specifications. In
> > particular the handling of non-native mode IDE storage class devices on
> > a PCI bus. For the IRQ mapping of the non-native ports consult your
> > bridge documentation.
> 
> Even if that is the case, they are all invalid/incorrect, and so Al Viro's
> patch is _still_ NAK'd.

Fine by me.  In that case we need to add
	depends on !FRV || BROKEN
to drivers/ata/Kconfig and be done with that.  BTW, empty libata-portmap.h
is equivalent to absent one - it still won't build.
