Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265759AbTIJVUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbTIJVUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:20:43 -0400
Received: from gprs147-211.eurotel.cz ([160.218.147.211]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265759AbTIJVUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:20:42 -0400
Date: Wed, 10 Sep 2003 22:11:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: What happened to SUSPEND_SAVE_STATE?
Message-ID: <20030910201124.GA11449@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

What happened to SUSPEND_SAVE_STATE?

pcmcia_socket_dev_suspend() still expects to receive it, but I do not
see any place where it is generated. Should it be killed from
device.h? And these 6 places fixed?

pavel@amd:/usr/src/linux$ grep SUSPEND_SAVE_STATE `find . -name "*.c"`
./arch/ppc/ocp/ocp-driver.c:            if (level == SUSPEND_SAVE_STATE && ocp_dev->driver->save_state)
./arch/arm/mach-sa1100/neponset.c:      if (level == SUSPEND_SAVE_STATE ||
./drivers/pcmcia/i82092.c:      return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
./drivers/pcmcia/sa1111_generic.c:      return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
./drivers/serial/8250_pci.c:                    serial8250_suspend_port(priv->line[i], SUSPEND_SAVE_STATE);
./drivers/serial/core.c:        case SUSPEND_SAVE_STATE:
pavel@amd:/usr/src/linux$

							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
