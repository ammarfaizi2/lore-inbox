Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266626AbUIEM6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266626AbUIEM6K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUIEM6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:58:10 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11419 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266622AbUIEM6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:58:05 -0400
Subject: Re: Intel ICH - sound/pci/intel8x0.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <9e4733910409041943490b9587@mail.gmail.com>
References: <9e4733910409041943490b9587@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094385318.1099.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 12:55:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 03:43, Jon Smirl wrote:
> The joystick PCI ID table in intel8x0.c is not correct. Joysticks and
> MIDI ports are ISA devices and need be located by manual probing. This
> ID table needs to be removed. Joystick and MIDI ports do not have PCI
> IDs.

It isn't that simple. The LPC bridge also contains the controls for the
joystick ports. You also need them for hotplug handling of the bridge
should someone stick one in a laptop docking station. The ID table also
ensures the driver is loaded. It's probably true that it will need
splitting up a bit if another driver also needs ownership of the LPC
bridge but for now that hasn't happened.

Also a lot of other vendors Midi and joystick ports do have PCI ids.

Alan

