Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTFOXop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 19:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTFOXop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 19:44:45 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:22757 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S263056AbTFOXoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 19:44:44 -0400
Subject: 2.5.71-mm1 and ACPI (Re: Broken USB, sound in 2.5.70-mmX series)
From: Michel Alexandre Salim <mas118@york.ac.uk>
To: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200306132247.17696.oliver@neukum.org>
References: <1055436599.6845.7.camel@bushido>
	 <200306122110.10207.oliver@neukum.org> <1055512702.6143.17.camel@bushido>
	 <200306132247.17696.oliver@neukum.org>
Content-Type: text/plain
Organization: University of York
Message-Id: <1055721510.6880.4.camel@bushido>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jun 2003 00:58:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 21:47, Oliver Neukum wrote:
> > > > > Do you see irqs for USB if you boot with acpi?
> > > >
> > > > Everything's on IRQ 9. That's why sound is broken as well it seems -
> > > > IRQ sharing does not work as well as it should.
> > >
> > > Did you try using pci= on the command line?
> >
> > Err.. no. What should I set pci= to?
> 
> pci=biosirq
> 
> 	HTH
Alas, it does not help :(. I tried 2.5.71-mm1 too, since there has been
ACPI updates - still the same, but I just realised my problem might be
related to the conspicuous drop in size of the initrd image created by
mkinitrd (on Red Hat 9):

2.4.20: 143K
2.5.69-mm8: 288K
2.5.70/1-mmX: 84K

It turns out that the 'insmod' binary is much smaller (down from 300+K
to 100+K), but that should not matter, since modules still load
properly?

Bizarre... anyone else has 2.5.70 and above working on a Centrino
notebook on a Red Hat system? 2.5.71 has a sweet Enhanced SpeedStep
module that finally detects Centrino, now if only I could get it working
properly...

Thanks,

Michel

