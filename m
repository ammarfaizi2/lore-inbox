Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUDZKnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUDZKnq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbUDZKmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:42:38 -0400
Received: from linux-bt.org ([217.160.111.169]:43414 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264545AbUDZKgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:36:03 -0400
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
In-Reply-To: <20040425235844.E13748@flint.arm.linux.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net>
	 <1082751264.4294.1.camel@pegasus>
	 <20040423213916.D2896@flint.arm.linux.org.uk>
	 <200404251653.55385.dtor_core@ameritech.net>
	 <20040425235844.E13748@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1082975742.28880.120.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 12:35:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

> Look, Dominik has done a fair amount of work in this area.  There is
> a set of patches which need to be worked through and merged in a
> controlled manner to get to the point where we can have a struct
> device for PCMCIA cards.  We'll get there eventually.  Please don't
> try to bypass this process - it won't work, and it'll only cause
> unnecessary merge problems with the existing patch sets.

right now we have two broken drivers. They are only broken, because we
need a device for loading the firmware. If the PCMCIA driver model
integrations is not yet ready, we should find a way to make the firmware
loading possible without having a device. We don't need the device for
any other task. Actually I don't know how to achieve it, but I think if
we give a NULL pointer to the request_firmware() call the firmware_class
should create a dummy device.

Regards

Marcel


