Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271562AbTGQS1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271555AbTGQSYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:24:19 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:2313
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271534AbTGQSX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:23:58 -0400
Date: Thu, 17 Jul 2003 11:38:59 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Input layer demand loading
Message-ID: <20030717183859.GA1003@matchmail.com>
Mail-Followup-To: Andrey Borzenkov  <arvidjaar@mail.ru>,
	Oliver Neukum  <oliver@neukum.org>, linux-kernel@vger.kernel.org
References: <20030716183343.GE2681@matchmail.com> <E19d16P-00044X-00.arvidjaar-mail-ru@f19.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19d16P-00044X-00.arvidjaar-mail-ru@f19.mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 09:14:49AM +0400, "Andrey Borzenkov"  wrote:
> 
> 
> -----Original Message-----
> 
> > 
> > On Wed, Jul 16, 2003 at 10:19:17PM +0400, Andrey Borzenkov wrote:
> > > >> True, but then if you try to open the port, you will only get the base
> > > >> joydev.o module loaded, not the gameport driver, which is what you
> > > >> _really_ want to have loaded, right?
> > > >> 
> > > >> So there really isn't much benifit to doing this, sorry.
> > > >
> > > > Why? It could work the way PCMCIA SCSI works.
> > > > Cardmgr loads the LLDD, but sd, sg, etc. are loaded
> > > > on demand.
> > > 
> > > how? SCSI (or USB, PCI, EISA etc) have driver-independent means to identify 
> > > device or at least device class.
> > > 
> > > But how are you going you going to know you need to load specific mouse driver 
> > > (logitech not microsoft) or specific joystick flavour? All that you possibly 
> > > know that you have _some_ mouse or _some_ joystick ...
> > 
> > Isn't that why we have hotplug in userspace?
> > 
> > That way, we know we have a mouse, but it's up to userspace to find out
> > what kind.
> > 
> 
> that is not what hotplug is for. What you describe is called "probing". 
> 
> Hotplug is there to load hardware driver once hardware is known, not
> to probe what hardware is there.
> 
> It can be used this way but it is rather abuse (or misuse) I'd say.

In many cases, you only know you have a class of devices, and you need more
probing after the initial hardware notification (hotplug).

There are many people that want all probing to be in user space.  Let's face
it, it's easier (no need to reboot) to upgrade a userspace probing app than
to install a new kernel.

Unfortunatly, it doesn't look like that will happen for 2.6, but I'd bet it
will in 2.7, and hotplug will probably be a considerable player in that area
(unless something better is used instead).
