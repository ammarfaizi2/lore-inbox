Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSGXTxS>; Wed, 24 Jul 2002 15:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSGXTxS>; Wed, 24 Jul 2002 15:53:18 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:38919 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317493AbSGXTxR>;
	Wed, 24 Jul 2002 15:53:17 -0400
Date: Wed, 24 Jul 2002 12:56:17 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.27
Message-ID: <20020724195617.GD11384@kroah.com>
References: <Pine.LNX.4.44.0207231012240.8911-100000@serv> <1027430194.31782.125.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1027430194.31782.125.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 18:46:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 02:16:34PM +0100, Alan Cox wrote:
> On Tue, 2002-07-23 at 09:16, Roman Zippel wrote:
> > Hi,
> > 
> > On Mon, 22 Jul 2002, Greg KH wrote:
> > 
> > > +		error = security_ops->inode_setattr(dentry, attr);
> > 
> > Am I the only one who'd like to see this as an inline function?
> > 1. It can be optimized away.
> > 2. It's easier to read.

Yes, I've considered it.  I might still wrap them in a inline function
if people _really_ don't like the look of them.

> You are not the only one. At the kernel summit there were discussions
> about both wrapping the few performance impacting ones in ifdefs, and/or
> using dynamic patching.

Yes, for the hooks that might affect performance (like the network ones)
they will probably be wrapped in inline functions, and controlled by a
config option.

thanks,

greg k-h
