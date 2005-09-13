Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVIMQUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVIMQUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVIMQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:20:23 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:51909 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S964846AbVIMQUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:20:21 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: multiple independent keyboard kernel support
Date: Tue, 13 Sep 2005 10:20:05 -0600
User-Agent: KMail/1.8.1
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Martin Mares <mj@ucw.cz>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Zoltan Szecsei <zoltans@geograph.co.za>, linux-kernel@vger.kernel.org
References: <4316E5D9.8050107@geograph.co.za> <200509121003.11086.bjorn.helgaas@hp.com> <F96CD1EB-5963-49CF-9B8B-7934925BE79D@mac.com>
In-Reply-To: <F96CD1EB-5963-49CF-9B8B-7934925BE79D@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509131020.05677.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 2:47 pm, Kyle Moffett wrote:
> On Sep 12, 2005, at 12:03:11, Bjorn Helgaas wrote:
> > On Sunday 11 September 2005 4:36 pm, Helge Hafting wrote:
> >> Look again.  X config files now have "IsolateDevice" and "BusID"
> >> to deal with this.  At least iff you get your X from ubuntu or
> >> debian testing . . .
> >
> > Yes, but I think IsolateDevice still isn't quite enough if you
> > have VGA devices behind PCI-PCI bridges.  In other words, devices
> > behind bridges still get disabled, even with IsolateDevice.
> >
> > And the ideal situation would be if IsolateDevice could be the
> > *default*, but the X bugzilla[1] says some devices have problems
> > with that.
> 
> IIRC, someone was working on a VGA arbiter and some PCI-access kernel  
> code
> upon which X.org could be rebuilt.  Then all the messy /dev/mem issues
> relating to PCI bus smashing go away (including the need for iopl, root
> privts, etc), and a properly configured system could run X.org as a  
> normal
> user on any attached devices that user has permission to, including  
> video
> cards, displays, keyboards, mice, graphics tablets, joysticks, etc.
> 
> Unfortunately the project is not exactly small, so it wasn't moving very
> quickly last I remember...

It's not small, but definitely not dead.  SGI ia64 boxes already
do this, and I'm got similar kernel support for HP ia64 boxes almost
ready to go.  But I don't work much on X.org, so I don't know how
long it will take to push the changes there.

And the kernel VGA arbiter is still missing, so I currently have
to turn off VGA console support in the kernel.

And of course, things would be much more interesting if the x86
support were in place.
