Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262381AbSJDVvR>; Fri, 4 Oct 2002 17:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262385AbSJDVvR>; Fri, 4 Oct 2002 17:51:17 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:49935 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262381AbSJDVvQ>;
	Fri, 4 Oct 2002 17:51:16 -0400
Date: Fri, 4 Oct 2002 14:53:51 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021004215350.GB8843@kroah.com>
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com> <3D9E0AB7.8090905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9E0AB7.8090905@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 05:40:07PM -0400, Jeff Garzik wrote:
> >diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
> >--- a/drivers/char/rocket.c	Fri Oct  4 13:47:29 2002
> >+++ b/drivers/char/rocket.c	Fri Oct  4 13:47:29 2002
> >@@ -1993,7 +1993,7 @@
> > 			isa_boards_found++;
> > 	}
> > #ifdef CONFIG_PCI
> >-	if (pcibios_present()) {
> >+	if (pci_present()) {
> > 		if(isa_boards_found < NUM_BOARDS)
> > 			pci_boards_found = init_PCI(isa_boards_found);
> > 	} else {
> 
> can be greatly simplified -- just simply all the code in the ifdef to 
> "if (isa_boards_found...) ...init_PCI..."

Heh, again, this driver needs some major work in regards to PCI
cleanups, it's quite old.  It can probably be converted over to use the
drivers/serial core too.

thanks,

greg k-h
