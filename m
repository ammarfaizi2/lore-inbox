Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSJHWfw>; Tue, 8 Oct 2002 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSJHWfw>; Tue, 8 Oct 2002 18:35:52 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:61599 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261376AbSJHWfv>; Tue, 8 Oct 2002 18:35:51 -0400
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210081456480.16276-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0210081456480.16276-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Oct 2002 23:51:35 +0100
Message-Id: <1034117495.31448.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > That's because normally pci_unregister_driver() or whatever is called in
> > cleanup_module(), but obviously to be able to call it the refcount has to 
> > be zero already...
> 
> That's true for drivers, but not for devices. Nonetheless, it's a big 
> problem that I've hoped would magically go away. Of course it won't, but I 
> don't have a solution for it off hand...

Is it actually cleanly solvable without sticking the refcounts in the
layer they belong not in driverfs ?

