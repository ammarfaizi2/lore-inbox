Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290813AbSBLHfP>; Tue, 12 Feb 2002 02:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSBLHfG>; Tue, 12 Feb 2002 02:35:06 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:34778 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290813AbSBLHe5>; Tue, 12 Feb 2002 02:34:57 -0500
Date: Tue, 12 Feb 2002 09:26:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] printk prefix cleanups.
In-Reply-To: <200202120718.g1C7IlS29064@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0202120923350.30276-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Pete Zaitcev wrote:

> > Here is a simple patch which reduces resultant binary size by 1.2k for 
> > this particular module (opl3sa2). [...]
> 
> >  #define OPL3SA2_MODULE_NAME	"opl3sa2"
> > +#define OPL3SA2_PFX		OPL3SA2_MODULE_NAME ": "
>  
> > -			printk(KERN_ERR "opl3sa2: MSS mixer not installed?\n");
> > +			printk(KERN_ERR OPL3SA2_PFX "MSS mixer not installed?\n");
> 
> I do not believe that it shortens binaries. Care to quote
> size(1) output and /proc/modules with and without the patch?

It does _not_ reduce the memory footprint, that i knew before doing the 
patch, the only thing it does do is reduce the resultant binary's 
filesize. Surely thats worth it just for the space saving? size(1) reports 
the same sizes for both patched and unpatched.

Regards,
	Zwane Mwaikambo


