Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUDQKtV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 06:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDQKtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 06:49:21 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:16614 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263799AbUDQKtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 06:49:20 -0400
Message-ID: <40810BA4.50803@colorfullife.com>
Date: Sat, 17 Apr 2004 12:49:08 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Riesen <fork0@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: POSIX message queues, libmqueue: mq_open, mq_unlink
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex wrote:

>Ok. It's just that every provider of the _kernel_ interface to user
>space has now to take care of being posix-compliant. Write the code for
>checks, iow. That is not the case for "open", for instance.
>And besides, with the patch applied the kernel is also posix compliant,
>isn't it?
>
No. E.g. mq_notify(,&{.sigev_notify=SIGEV_THREAD) cannot be implemented 
in kernel space. And sys_mq_getsetattr isn't posix compliant either - 
the user space library must implement mq_getattr and mq_setattr on top 
of the kernel API.
The kernel API was designed to be simple and flexible. Perhaps we want 
to extend the kernel implementation in the future, and then a leading 
slash could be used to indicate that we are using the new features.

--
    Manfred

