Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267284AbTAVC3A>; Tue, 21 Jan 2003 21:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTAVC3A>; Tue, 21 Jan 2003 21:29:00 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:34010 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267284AbTAVC27>; Tue, 21 Jan 2003 21:28:59 -0500
Date: Tue, 21 Jan 2003 20:37:47 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Adam Belay <ambx1@neo.rr.com>
cc: Jaroslav Kysela <perex@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: [alsa, pnp] more on opl3sa2
In-Reply-To: <20030121182303.GI26108@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0301212034340.1577-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Adam Belay wrote:

> How does this sound...
> 1.) detach pnp card service matching from the driver model, the driver model is
> what is imposing this one card per driver limit.
> 2.) create a special pnp_driver that handles cards and forwards driver model calls
> to the pnp card services, we can use attach_driver to avoid matching problems.
> 
> design goals for these changes should be as follows:
> 1.) multiple drivers can bind to one card
> 2.) pnp_attach, pnp_detach, and pnp status should be phased out and replaced with
> the special card driver, in other words the driver model can take care of this.

First of all I admit that I haven't been following closely, so I maybe way 
off.

Anyway, the old ISAPnP used, AFAIR, struct pci_bus for the card and struct
pci_device for the devices. So what's wrong with using the basically the
same abstraction with the driver model, which has buses and devices as
well. That means each device can have its own driver, and I suppose that
should be good enough (as opposed to only one driver per card).

But probably I'm missing something?

--Kai


