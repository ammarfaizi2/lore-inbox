Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTICNqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbTICNpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:45:05 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:35821 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262161AbTICNoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:44:44 -0400
Message-ID: <3F55F0A2.3010209@terra.com.br>
Date: Wed, 03 Sep 2003 10:46:10 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix SMP support on cdu535 cdrom driver
References: <3F550E0E.7020502@terra.com.br>
In-Reply-To: <3F550E0E.7020502@terra.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe W Damasio wrote:
>     Hi,
> 
>     Patch against 2.6-test4.
> 
>     I'm not sure this is the right fix, since my knowledge on cdrom 
> drivers tends to /dev/zero...but, here we go:
> 
>     Replace cli/sti on sony_sleep with wait_queue, using a device 
> spinlock to lock 'enable_interrupts' and the queueing stuff.

	Which it based from workqueue::flush_workqueue, but I don't know if 
the same algorithm applies to this block driver.

	Could someone with more experience on block drivers review this?

	Thanks.

Felipe

