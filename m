Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSFJOjt>; Mon, 10 Jun 2002 10:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSFJOjs>; Mon, 10 Jun 2002 10:39:48 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:31918 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315420AbSFJOjr>; Mon, 10 Jun 2002 10:39:47 -0400
Date: Mon, 10 Jun 2002 09:39:44 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Patrick Mochel <mochel@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PCI device matching fix
In-Reply-To: <Pine.LNX.4.33.0206100623230.654-100000@geena.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0206100935080.20438-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Patrick Mochel wrote:

> > And, you need to set the owner from the module which you want to protect.
> > 
> > So in the your driver:
> > 
> > struct pci_driver my_drv {
> > 	probe: ...
> > 	driver : {
> > 		owner: THIS_MODULE,
> > 	}
> > }
> 
> This is certainly not the prettiest, and I've run into it when setting 
> other generic driver fields. Is there a cleaner way to do this?

Depends on your definition of clean ;) The only thing I can think of is
adding some new macro which hides it. Which is still ugly. Or, of course,
unnamed struct members, which however I think is not supported by gcc < 3.
It may be something to think about.

> pci_register_driver() doesn't inc the refcount. The refcount is held at 1 
> by the module loading code, IIUC, until module_init() is done. After that, 
> the refcount stays at 0 until someone uses it.

Sounds okay. Well, I'm generally lost in too many patches, if you put
the whole thing onto bkbits.net or so, I'll try to give it a look.

--Kai

