Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVCWVoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVCWVoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVCWVoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:44:15 -0500
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:49938 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262929AbVCWVoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:44:12 -0500
Date: Wed, 23 Mar 2005 22:44:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] I2C Part 1 - Remove some redundancy from the i2c-core.c
 file
Message-Id: <20050323224430.634e0a75.khali@linux-fr.org>
In-Reply-To: <42418B36.5030407@mvista.com>
References: <42418B36.5030407@mvista.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

> Call i2c_transfer() from i2c_master_send() and i2c_master_recv()
> to avoid the redundant code that was in all three functions.

I like this. You're right, there is code duplication here, which we can
get rid of, so let's do so. I'd only have one comments about your patch:

You can get rid of the dev_dbg calls in i2c_master_send() and
i2c_master_recv() altogether IMHO. I recently updated i2c_transfer() to
make it more verbose in debug mode [1], so the debug messages in
i2c_master_send() and i2c_master_recv() are mostly redundant now as far
as I can see.

[1] http://archives.andrew.net.au/lm-sensors/msg29859.html

Thanks,
-- 
Jean Delvare
