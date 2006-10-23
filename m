Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWJWF4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWJWF4B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 01:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbWJWF4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 01:56:00 -0400
Received: from adsl-ull-137-166.41-151.net24.it ([151.41.166.137]:20263 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S1751539AbWJWF4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 01:56:00 -0400
Message-ID: <453C58D9.4070502@abinetworks.biz>
Date: Mon, 23 Oct 2006 07:53:29 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giridhar Pemmasani <pgiri@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
References: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
In-Reply-To: <20061023054119.75745.qmail@web32415.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Have got the same problem. I just add the following:

1) dmesg claims __create_workqueue and __destroy_workqueue are undefined 
(kernel syms)
2) I've checked out System.map and they're of course present
3) no problem under 2.6.18.1
4) from ndiswrapper-1.15 to ndiswrapper-1.26

By the way, i would like so much if someone explain me why, since 
2.6.18, on my Acer Laptop i had to add irqpoll to correctly boot (had 
already to use acpi=noirq) and still have strange errors on DVD 
detection at boot which strangely has not any consequence later.
The problem is there since 2.6.18.

Thanks,

Gianluca


Giridhar Pemmasani wrote:

>It seems that the kernel module loader taints ndiswrapper module as
>proprietary, but it is not - it is fully GPL: see
>http://directory.fsf.org/sysadmin/hookup/ndiswrapper.html
>
>Note that when a driver is loaded, ndiswrapper does taint the kernel (to be
>more accurate, it should check if the driver being loaded is GPL or not, but
>that is not done).
>
>Thanks,
>Giri
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

