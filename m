Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWGGEFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWGGEFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 00:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWGGEFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 00:05:20 -0400
Received: from xenotime.net ([66.160.160.81]:46245 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750762AbWGGEFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 00:05:20 -0400
Date: Thu, 6 Jul 2006 21:08:05 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: yh@bizmail.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Module link
Message-Id: <20060706210805.b9e952ca.rdunlap@xenotime.net>
In-Reply-To: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>
References: <3306.58.105.227.226.1152244539.squirrel@58.105.227.226>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 13:55:39 +1000 (EST) yh@bizmail.com.au wrote:

> Thanks for all helps. The module can now be loaded. There are some other
> issues as descripbled as follows:
> 
> 1. The module I used links to i2c drivers. It works fine in kernel 2.4
> after "insmod NewModule.o", but now it has a NULL point in kernel 2.6 when
> to init it. It seems that the i2c driver is not linked in the module. How
> can I link an i2c to my driver module?

Sorry, I don't understand the question.
Where is the driver source code?

> 2. In kernel 2.4, when I call "insmod NewModule.o", the insmod can find
> the path of the NewModule.o and to init the module. In 2.6 kernel, the
> "insmod NewModule.ko" does not know the path, so I have to specify the
> path explicitly as "insmod
> /lib/modules/2.6.8.1/kernel/drivers/char/NewModule.ko" to make it work. I
> guess the above problem in question 1 may also related to this issue. What
> did I wrong here?

In module-init-tools, insmod requires full path and modprobe
does not (it searches for the file).

---
~Randy
