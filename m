Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbTA2V76>; Wed, 29 Jan 2003 16:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266733AbTA2V75>; Wed, 29 Jan 2003 16:59:57 -0500
Received: from mail.somanetworks.com ([216.126.67.42]:7362 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S266731AbTA2V74>; Wed, 29 Jan 2003 16:59:56 -0500
Date: Wed, 29 Jan 2003 17:09:14 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Ed Vance <EdV@macrolink.com>
cc: "'Rusty Lynch'" <rusty@linux.co.intel.com>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: RE: [Pcihpd-discuss] [RFC] Enhance CPCI Hot Swap driver
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33D71@EXCHANGE>
Message-ID: <Pine.LNX.4.44.0301291655040.17194-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003, Ed Vance wrote:

> On Tue, January 28, 2003 at 12:40 AM, Rusty Lynch wrote:
> > 
> > On Tue, 2003-01-28 at 23:50, Stanley Wang wrote:
> > > Hi, Scott,
> > > After reading your CPCI Hot Swap support codes, I have a suggestion
> > > to enhance it:
> > > How about to make it be full hot swap compliant?
> > > I mean we could also do some works like "disable_slot" when 
> > we receive
> > > the #ENUM & EXT signal. Hence the user could yank the hot 
> > swap board 
> > > without issuing command on the console.
> > > How do you think about it?
> > > 
> > 
> > How does this behavior translate to "full hot swap 
> > compliant"?  I assume
> > you are talking about wording from PICMG 2.16, which in my opinion
> > describes the full software stack, not just the driver.  Any kind of
> > full CPCI solution would have all the user space components to
> > coordinate disabling a slot before the operator physically yanks the
> > board (and therefore behave as PICMG specifies).  I'm not so sure the
> > driver knows enough to make a policy decision on what to do when an
> > operator bypasses the world and just yanks a board out with 
> > no warning.
> 
> How is this functionally different from ejecting a PCMCIA card in use? Is
> the driver obligated to do more than prevent a system crash and present
> errors to user level until the last close? 

cPCI hotswap as defined in the PICMG 2.1 specification is a different 
beast from PCMCIA because it was purposely defined to give software a 
chance to do something before the device disappears.  The specification
even goes so far as to say that the system is in an undefined state if
a device is yanked without waiting for the system software indicating it
is safe to do so.  In reality, handling someone yanking a board is indeed 
desireable, although it seems unlikely that the vast array of PCI device
drivers will ever get updated to handle it.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

