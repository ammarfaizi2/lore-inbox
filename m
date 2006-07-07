Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWGGGAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGGGAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWGGGAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:00:09 -0400
Received: from mail.cs.umn.edu ([128.101.35.202]:16841 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1751126AbWGGGAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:00:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17581.63026.514260.403228@hound.rchland.ibm.com>
Date: Fri, 7 Jul 2006 00:50:42 -0500
To: yh@bizmail.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module link
In-Reply-To: <2513.203.217.29.133.1152250423.squirrel@203.217.29.133>
References: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>
	<20060706210805.b9e952ca.rdunlap@xenotime.net>
	<2513.203.217.29.133.1152250423.squirrel@203.217.29.133>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: boutcher@cs.umn.edu (Dave C Boutcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 15:33:43 +1000 (EST), yh@bizmail.com.au said:
> 
> Thanks Randy. Let me clarify it.
> I have a driver module (NewSerialModule.ko) and I build it for module
> load. This driver module uses i2c functions. It was fine to init this
> module in kernel 2.4 as the i2c functions are exported in i2c Makefile.
> 
> In kernel 2.6, I loaded this module and got NULL point exception. I
> checked the module map, all i2c functions are not linked. I also checked
> i2c, there is no export for i2c in kernel 2.6. So, my question is how can
> I link the dirvers/i2c to my driver module in drivers/char directory? How
> to export a directory to be a library such as i2c? In general, how to link
> another directory functions by a module in kernel 2.6?

It is difficult for any of us to offer assistance unless you provide a
pointer to your source code.

However, I will point out that the i2c functions are exported from
drivers/i2c/i2c-core.c, so you should make sure you have that module
either built into your kernel or loaded.

Dave B
