Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUIVVJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUIVVJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267828AbUIVVIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:08:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:993 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267864AbUIVVGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:06:49 -0400
Subject: Re: Is there a user space pci rescan method?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Aubin <daubin@actuality-systems.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E8F8DBCB0468204E856114A2CD20741F2C13D2@mail.local.ActualitySystems.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13D2@mail.local.ActualitySystems.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095883470.4526.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 22 Sep 2004 21:04:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-22 at 21:30, Dave Aubin wrote:
> Hi,
>  
>   Is there a user space or perhaps simple kernel module way to
> rescan the pci bus?  I currently have a user mode program modify
> the pci bus, but I can not push the user mode program to the
> bios for reasons I can't get in to.  

Take a look at drivers/hotplug. As far as Linux is concerned you've got
a hotplug PCI slot if you have to poke at it. Alternatively if its a
general funny such as a card you have to poke to reveal devices behind
it a PCI quirk would probably do the trick.

