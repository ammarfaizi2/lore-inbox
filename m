Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262625AbSKDT3F>; Mon, 4 Nov 2002 14:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbSKDT3F>; Mon, 4 Nov 2002 14:29:05 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24210 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262625AbSKDT3E>;
	Mon, 4 Nov 2002 14:29:04 -0500
Message-ID: <3DC6CB01.7080102@us.ibm.com>
Date: Mon, 04 Nov 2002 11:31:13 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cpu_devclass removed from cpu.h
References: <20021102003027.GD16236@admingilde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> hi :)
> 
> the 'extern struct device_class cpu_devclass;' was removed from cpu.h
> lately.
> is this intentional or will it come back in some other include file?
> 
> i need that class to be able to register a interface for cpus
> in my tree.
> 
> 
> thanks

There were no immediate plans to put that back in linux/cpu.h.  It is 
now defined and used in drivers/base/cpu.c.  cpu_devclass is registered 
with driverfs (err..  sysfs) there.  If you need it, you should be able 
to reference it...  just stick an extern in your file.

Check out the thread '[patch] Core sysfs Topology 2.5.45'.  These are 
the patches that modified the sysfs topology system.

Cheers!

-Matt

