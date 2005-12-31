Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbVLaR7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLaR7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVLaR7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:59:39 -0500
Received: from wscnet.wsc.cz ([212.80.64.118]:40070 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932305AbVLaR7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:59:38 -0500
Message-ID: <43B6C6F3.7080109@liberouter.org>
Date: Sat, 31 Dec 2005 18:59:15 +0100
From: Jiri Slaby <slaby@liberouter.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Jason Dravet <dravet@hotmail.com>
CC: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: RFC: add udev support to parport_pc
References: <BAY103-F5ABE5F52E47CC9DD71D21DF2B0@phx.gbl>
In-Reply-To: <BAY103-F5ABE5F52E47CC9DD71D21DF2B0@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Dravet napsal(a):
> Here is a patch to parport_pc.c that adds udev support.  Without it
> sysfs does not have enough information to give to udev so the lp and
> parport nodes can be created.  The only problem I have is the
> kernel_oops when I do the following: insmod parport, insmod parport_pc,
> rmmod parport_pc, rmmod parport, insmod parport, insmod parport_pc,
> rmmod parport_pc, kernel oops. 
[snip]
> +    if (p->base == 888) /* 888 is dec for 378h */
> +    {
> +        class_device_create(parallel_class, NULL, MKDEV(6, 0), NULL,
> "lp0");
> +        class_device_create(parallel_class, NULL, MKDEV(99, 0), NULL,
> "parport0");
> +    }
use please
if () {
}
instead of
if ()
{
}
like the surrounding code

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
