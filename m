Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSGWMAY>; Tue, 23 Jul 2002 08:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318039AbSGWMAY>; Tue, 23 Jul 2002 08:00:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:11508 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317816AbSGWMAX>; Tue, 23 Jul 2002 08:00:23 -0400
Subject: Re: [BK PATCH] LSM changes for 2.5.27
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
In-Reply-To: <Pine.LNX.4.44.0207231012240.8911-100000@serv>
References: <Pine.LNX.4.44.0207231012240.8911-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jul 2002 14:16:34 +0100
Message-Id: <1027430194.31782.125.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 09:16, Roman Zippel wrote:
> Hi,
> 
> On Mon, 22 Jul 2002, Greg KH wrote:
> 
> > +		error = security_ops->inode_setattr(dentry, attr);
> 
> Am I the only one who'd like to see this as an inline function?
> 1. It can be optimized away.
> 2. It's easier to read.

You are not the only one. At the kernel summit there were discussions
about both wrapping the few performance impacting ones in ifdefs, and/or
using dynamic patching.

