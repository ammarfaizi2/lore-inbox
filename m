Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030289AbWBAEc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbWBAEc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWBAEc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:32:29 -0500
Received: from spooner.celestial.com ([192.136.111.35]:57223 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030289AbWBAEc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:32:28 -0500
Date: Tue, 31 Jan 2006 23:38:24 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-ID: <20060201043824.GF23039@kurtwerks.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060129144533.128af741.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:45:33PM -0800, Andrew Morton took 397 lines to write:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm4/

depmod loop:

$ sudo make modules_install:
...
  INSTALL sound/soundcore.ko
  if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F
  System.map  2.6.16-rc1-mm4krw-1; fi
  WARNING: Loop detected:
  /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko needs
  serial_core.ko which needs 8250.ko again!
  WARNING: Module
  /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250.ko
  ignored, due to loop
  WARNING: Module
  /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/serial_core.ko
  ignored, due to loop
  WARNING: Module
  /lib/modules/2.6.16-rc1-mm4krw-1/kernel/drivers/serial/8250_pci.ko
  ignored, due to loop
  [~/kernel/linux-2.6.16-rc1-mm4]$

Kurt
-- 
The Arkansas legislature passed a law that states that the Arkansas
River can rise no higher than to the Main Street bridge in Little
Rock.
