Return-Path: <linux-kernel-owner+willy=40w.ods.org-S311791AbUKBBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S311791AbUKBBbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 20:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S278626AbUKBBbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 20:31:39 -0500
Received: from rproxy.gmail.com ([64.233.170.199]:3027 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S383999AbUKBANb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:13:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Q8aB5JJxBw8QGyDDR2jrv/M5VjuBMB8OUwfNA+qwsbQfomrN17WARmd7lIdq2J3MLB0E4/HJLtrsW7xxqokBVgFqYk1QSd7zrVkKCDNuA6FGMuUBKGA7iXtlaEKNNlXsQIARehLJ6QzIRcc1S6q2t6JWamAwtTg5H60qQqPC1ns=
Message-ID: <58cb370e0411011613305465e6@mail.gmail.com>
Date: Tue, 2 Nov 2004 01:13:18 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/14] FRV: IDE fixes
Cc: dhowells@redhat.com, torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       uclinux-dev@uclinux.org
In-Reply-To: <1099349584.16385.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com>
	 <200411011930.iA1JULRt023195@warthog.cambridge.redhat.com>
	 <1099349584.16385.71.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2004 22:53:06 +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Llu, 2004-11-01 at 19:30, dhowells@redhat.com wrote:
> >               memset(&hwif->hw, 0, sizeof(hwif->hw));
> > +#ifndef IDE_ARCH_OBSOLETE_INIT
> > +             ide_std_init_ports(&hwif->hw, base, (ctl | 2));
> > +             hwif->hw.io_ports[IDE_IRQ_OFFSET] = 0;
> > +#else
> >               ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
> > +#endif
> 
> Do you really need this, and if so please why ?

Because IDE_ARCH_OBSOLETE_INIT is not defined? [ See ide.h. ]
