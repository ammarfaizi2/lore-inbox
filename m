Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271663AbTGRAcz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271664AbTGRAcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:32:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:18642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271663AbTGRAcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:32:52 -0400
Message-ID: <1173.4.4.25.4.1058489266.squirrel@www.osdl.org>
Date: Thu, 17 Jul 2003 17:47:46 -0700 (PDT)
Subject: Re: 2.5.72 insmod question
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <yiding_wang@agilent.com>
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D55212@axcs03.cos.agilent.com>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D55212@axcs03.cos.agilent.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I completed a fibre channel driver change to support for 2.5.72 (suppose to
> be 2.6 compatible) and compiled it OK.  When trying load the driver with
> "insmod", it complains with the message "insmod: QM_MODULES: Function not
> implemented".
>
> I tried kernel built module qla1280.o and got the same result.  It seems the
> insmod utility in my system is not compatible with new 2.5.72 built module.
>
> I have 2.4.20-8 kernel installed first and driver loads and runs fine.
> Later added 2.5.72 kernel and booted with its bzImage works fine too.
> However, the insmod utility I am using to load new driver was from 2.4.20-8
> which has system_query_module() being called.  I checked Doc. and source
> code for 2.5.72 and could not find same function call in module.c
>
> Some web documents mentioned that the module installation is changed from
> 2.4.x to 2.5.x.  So far I am still looking for the solution and hope someone
> can help me on the issue.
>
> I am compiling the driver out side of kernel source tree but using kernel
> environmental variables for compatibility.

You need to use the 2.5/2.6 module-init-tools from
  http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

modutils from 2.4 won't work with 2.5/2.6.

And you probably should read over the 2.6 migration document:
  http://www.codemonkey.org.uk/post-halloween-2.5.txt

~Randy



