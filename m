Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbRF3JjR>; Sat, 30 Jun 2001 05:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbRF3JjH>; Sat, 30 Jun 2001 05:39:07 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:23176 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264883AbRF3Jiz>; Sat, 30 Jun 2001 05:38:55 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 30 Jun 2001 02:38:50 -0700
Message-Id: <200106300938.CAA23552@baldur.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Russell King <rmk@arm.linux.org.uk>
>On Sat, Jun 30, 2001 at 08:26:22AM +0100, Alan Cox wrote:
>> #2
>> 	dep_tristate $FOO $BAR
>> 
>> to say 'FOO requires BAR and must be a similar setting _IF_CONFIGURED_'

>Err, how can $BAR be undefined?  Configure sets all config variables which
>are answered with 'n' to 'n'.

One example would be processing of the following line on a non-sparc
computer (from linux-2.4.6-pre6/drivers/sbus/audio/Config.in):

dep_tristate '  Sun Microsystems userflash support' CONFIG_MTD_SUN_UFLASH $CONFIG_SPARC64

I think this could also come up for drivers that depend on
$CONFIG_ISA when configured for non-PC platforms that do not ask
about ISA support.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
