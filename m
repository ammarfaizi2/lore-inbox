Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbTIQXp3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 19:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbTIQXp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 19:45:29 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:27945 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262901AbTIQXp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 19:45:27 -0400
Date: Wed, 17 Sep 2003 19:45:23 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200309172345.h8HNjNs13415@devserv.devel.redhat.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Altix console driver
In-Reply-To: <mailman.1063838640.11239.linux-kernel2news@redhat.com>
References: <20030917222414.GA25931@sgi.com> <mailman.1063838640.11239.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Just a simple addition to drivers/char for the Altix serial console.
>> 
>>  MAINTAINERS              |    6 
>>  drivers/char/Kconfig     |   16 
>>  drivers/char/Makefile    |    1 
>>  drivers/char/sn_serial.c | 1189 +++++++++++++++++++++++++++++++++++++++++++++++
> 
> Would it be more appropriate to place this under arch/ia64?

It was discussed on other occasions, and it "was decided"
(sprinkled with holy penguin pee) that such things go into
drivers/, e.g. drivers/serial/sunsu.c is Sun-specific,
but it helps to keep it near drivers/serial/8250.c, for
diffing. If an additional API is involved, e.g.
sbus_alloc_consistent, drivers get a subdir like
drivers/sbus or drivers/s390. Also, you never know
when sharing hits you across the head, e.g. sparc, sparc64,
and m68k (for sun3) share some drivers.

-- Pete
