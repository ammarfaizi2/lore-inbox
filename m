Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271001AbTGPST2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTGPSRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:17:47 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:38852 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S271031AbTGPSQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:16:29 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Input layer demand loading
Date: Wed, 16 Jul 2003 20:29:50 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200307162219.17067.arvidjaar@mail.ru>
In-Reply-To: <200307162219.17067.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307162029.50195.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Juli 2003 20:19 schrieb Andrey Borzenkov:
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

Exactly, you'd only load the hardware independent part on demand.
Or, alternatively, you'd record the driver to load in the hotplug script
and load it on demand.

	Regards
		Oliver

