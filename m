Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTLQQR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTLQQR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:17:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:11413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264476AbTLQQR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:17:57 -0500
Date: Wed, 17 Dec 2003 08:17:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
cc: Jeff Garzik <jgarzik@pobox.com>, arjanv@redhat.com,
       Gabriel Paubert <paubert@iram.es>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Martin Mares <mj@ucw.cz>, zaitcev@redhat.com, hch@infradead.org
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <3FE004BF.7020403@intel.com>
Message-ID: <Pine.LNX.4.58.0312170815450.8541@home.osdl.org>
References: <3FDCC171.9070902@intel.com> <3FDCCC12.20808@pobox.com> 
 <3FDD8691.80206@intel.com> <20031215103142.GA8735@iram.es>  <3FDDACA9.1050600@intel.com>
 <1071494155.5223.3.camel@laptop.fenrus.com> <3FDDBDFE.5020707@intel.com>
 <Pine.LNX.4.58.0312151154480.1631@home.osdl.org> <3FDEDC77.9010203@intel.com>
 <Pine.LNX.4.58.0312160844110.1599@home.osdl.org> <3FDFF81F.7040309@intel.com>
 <Pine.LNX.4.58.0312162240040.8541@home.osdl.org> <3FDFFDEC.7090109@pobox.com>
 <3FE004BF.7020403@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Dec 2003, Vladimir Kondratiev wrote:
> 
> What you will miss, is uniform access for all devices, including those
> you are not managing as PCI-E. Notable example is bridges. I can't
> provide more info (see prev. mail about brain dead, I don't want it to
> be my last day at work), but you may found appropriate to tweak some
> stuff for bridges in extended space. One may use /proc/bus/pci/ or
> 'setpci' for this. Obviously, in this case you have no driver, and
> generic access method would help you. Also, 'lspci' don't know about
> device drivers, it need generic way to access config.

Ok, the /proc/bus/pci argument is a pretty good one, so having a uniform 
way to access the config space sounds fair. 

And it doesn't look that ugly any more, so I guess if just the detection 
can be fixed (and real devices enter the market) I don't see any reason 
not to do it that way.

		Linus
