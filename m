Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUIURkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUIURkJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267923AbUIURkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:40:00 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:37808 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267918AbUIURjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:39:36 -0400
Message-ID: <9e4733910409211039273d5a2f@mail.gmail.com>
Date: Tue, 21 Sep 2004 13:39:33 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Michael Hunold <hunold-ml@web.de>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Cc: Greg KH <greg@kroah.com>, Michael Hunold <hunold@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       sensors@stimpy.netroedge.com
In-Reply-To: <41506099.8000307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
	 <41506099.8000307@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a related I2C problem with EEPROMs and DDC monitors. DDC
monitors look just like EEPROMs, the EEPROM driver can even read most
of them. But there are DDC monitors that need special wakeup sequences
before their ROMs will appear.

EEPROM and DDC are both algo_bit clients. When you attach a bus to
algo_bit both clients will run. There is concern that sending the
special DDC wake up sequence down non-DDC buses might mess up the bus.

A proposal was made to implement different classes of algo_bit clients
but this was never implemented. Would a class solution help with the
dvb problem too?


-- 
Jon Smirl
jonsmirl@gmail.com
