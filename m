Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWGKWKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGKWKs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWGKWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:10:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52999 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932190AbWGKWKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:10:46 -0400
Date: Wed, 12 Jul 2006 00:10:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1: drivers/ide/pci/jmicron.c warning
Message-ID: <20060711221045.GC13938@stusta.de>
References: <20060709021106.9310d4d1.akpm@osdl.org> <20060711125258.GN13938@stusta.de> <20060711140257.GA6820@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711140257.GA6820@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 10:02:57AM -0400, Alan Cox wrote:
> On Tue, Jul 11, 2006 at 02:52:58PM +0200, Adrian Bunk wrote:
> >   CC      drivers/ide/pci/jmicron.o
> > drivers/ide/pci/jmicron.c: In function ???ata66_jmicron???:
> > drivers/ide/pci/jmicron.c:99: warning: control reaches end of non-void function
> 
> If your gcc does this please file a gcc bug report
> 
> > At least from gcc's perspective, this warning is correct, and it should 
> > therefore be fixed.
> 
> No. port_type is an enum. Each enum value in question is present in the 
> switch (and gcc knows this), each has a return. Your compiler is buggy.

I'm not a C expert myself, so I asked a gcc developer on irc.

The problem is that C allows you to assign other values than the ones 
listed in the enum to the variable.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

