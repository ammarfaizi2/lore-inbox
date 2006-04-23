Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWDWRYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWDWRYS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 13:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWDWRYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 13:24:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44087 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751432AbWDWRYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 13:24:18 -0400
Date: Sun, 23 Apr 2006 13:24:16 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: How can I prevent MTD to access the end of a flash device ?
In-reply-to: <cda58cb80604231006x4911598bg6c1e3d62f07d80e7@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0604231323180.3603@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
 <cda58cb80511220658n671bc070v@mail.gmail.com>
 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
 <cda58cb80604231006x4911598bg6c1e3d62f07d80e7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2006, Franck Bui-Huu wrote:

> Nicolas,
> 
> 2005/11/22, Nicolas Pitre <nico@cam.org>:
> > On Tue, 22 Nov 2005, Franck wrote:
> >
> > > Hi,
> > >
> > > I have two questions that I can't answer by my own. I tried to look at
> > > FAQ and documentation on MTD website but found no answer.
> >
> > Please consider using the MTD mailing list next time (you certainly read
> > about it on the MTD web site).
> >
> > > First question is about size of flash. I have a Intel strataflash
> > > whose size is 32MB but because of a buggy platform hardware I can't
> > > access to the last 64KB of the flash. How can I make MTD module aware
> > > of this new size. The restricted map size is initialized by my driver
> > > but it doesn't seem to be used by MTD.
> >
> > The easiest thing to do is to define MTD partitions, the last one being
> > the excluded flash area.
> >
> 
> I hope you don't mind if I continue this thread 5 months later...I put
> this issue in my TODO list and now I really need to fix it.
> 
> Your advice seems fine, but it brings some restrictions on flash
> concatenations: for example, if I have 2 flashes of 32Mbytes, I need
> to create 2 partitions whose sizes are 32M - 64K bytes but then I
> can't concatenate these two partitions anymore since concatenation
> works with mtd devices, not partitions, does it ?

MTD partitions are MTD "devices" as well.


Nicolas
