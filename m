Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbTGPSVe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271046AbTGPSUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:20:32 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:1035
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271047AbTGPSSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:18:49 -0400
Date: Wed, 16 Jul 2003 11:33:43 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: Input layer demand loading
Message-ID: <20030716183343.GE2681@matchmail.com>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
References: <200307162219.17067.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307162219.17067.arvidjaar@mail.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 10:19:17PM +0400, Andrey Borzenkov wrote:
> >> True, but then if you try to open the port, you will only get the base
> >> joydev.o module loaded, not the gameport driver, which is what you
> >> _really_ want to have loaded, right?
> >> 
> >> So there really isn't much benifit to doing this, sorry.
> >
> > Why? It could work the way PCMCIA SCSI works.
> > Cardmgr loads the LLDD, but sd, sg, etc. are loaded
> > on demand.
> 
> how? SCSI (or USB, PCI, EISA etc) have driver-independent means to identify 
> device or at least device class.
> 
> But how are you going you going to know you need to load specific mouse driver 
> (logitech not microsoft) or specific joystick flavour? All that you possibly 
> know that you have _some_ mouse or _some_ joystick ...

Isn't that why we have hotplug in userspace?

That way, we know we have a mouse, but it's up to userspace to find out
what kind.
