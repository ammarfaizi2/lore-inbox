Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTBLWbQ>; Wed, 12 Feb 2003 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267899AbTBLWbQ>; Wed, 12 Feb 2003 17:31:16 -0500
Received: from bv-n-3b5d.adsl.wanadoo.nl ([212.129.187.93]:49414 "HELO
	legolas.dynup.net") by vger.kernel.org with SMTP id <S267881AbTBLWbP>;
	Wed, 12 Feb 2003 17:31:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
Message-Id: <200302122246.19225@gandalf>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>, andmike@us.ibm.com,
       james.bottomley@steeleye.com, linux-kernel@vger.kernel.org,
       fischer@norbit.de, Tommy.Thorn@irisa.fr
Subject: Re: [PATCH] fix scsi/aha15*.c for 2.5.60
Date: Wed, 12 Feb 2003 23:41:02 +0100
X-Mailer: KMail [version 1.3.2]
References: <3E49DC38.52D278C4@verizon.net>
In-Reply-To: <3E49DC38.52D278C4@verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 February 2003 06:31, Randy.Dunlap wrote:
> Hi,
> 
> Here are patches to aha152x.c and aha1542.c so that they will build
> in 2.5.60.
> 
> Please review and apply or comment...

well it applies, compiles, but it gives a warning on depmod in make 
modules_install:

<snip>
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.60; fi
WARNING: /lib/modules/2.5.60/kernel/drivers/scsi/aha152x.ko needs unknown 
symbol scsi_put_command
WARNING: /lib/modules/2.5.60/kernel/drivers/scsi/aha152x.ko needs unknown 
symbol scsi_get_command

this is the relevant part of my .config:
CONFIG_SCSI=m
CONFIG_SCSI_AHA152X=m

this gives these modules in /lib/modules/2.5.60/kernel/drivers/scsi/:
aha152x.ko  scsi_mod.ko  sg.ko

what am i missing??

	Rudmer
> 
> Thanks,
> ~Randy
