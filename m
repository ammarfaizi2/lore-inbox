Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbTCGMBM>; Fri, 7 Mar 2003 07:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261533AbTCGMBL>; Fri, 7 Mar 2003 07:01:11 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:22266 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S261520AbTCGMBK>; Fri, 7 Mar 2003 07:01:10 -0500
Date: Fri, 7 Mar 2003 13:11:32 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.64+bk] Warning: "platform_bus_type" [drivers/pcmcia/tcic.ko] undefined!
Message-ID: <20030307121132.GA26044@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "platform_bus_type" [drivers/pcmcia/tcic.ko] undefined!
*** Warning: "platform_bus_type" [drivers/pcmcia/i82365.ko] undefined!


grep -ir platform_bus_type include drivers
include/linux/device.h:extern struct bus_type platform_bus_type;
drivers/base/platform.c:        pdev->dev.bus = &platform_bus_type;
drivers/base/platform.c:struct bus_type platform_bus_type = {
drivers/base/platform.c:        return bus_register(&platform_bus_type);
drivers/pcmcia/tcic.c:  .bus = &platform_bus_type,
drivers/pcmcia/hd64465_ss.c:    .bus = &platform_bus_type,
drivers/pcmcia/sa1100_generic.c:        .bus            = &platform_bus_type,
drivers/pcmcia/i82365.c:        .bus = &platform_bus_type,


grep -i pcmcia .config
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
# PCMCIA/CardBus support
CONFIG_PCMCIA=m
# CONFIG_PARPORT_PC_PCMCIA is not set
# PCMCIA SCSI adapter support
# CONFIG_SCSI_PCMCIA is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
# PCMCIA network device support
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_PCMCIA_AXNET is not set
# PCMCIA character devices


