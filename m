Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129388AbRBOKfP>; Thu, 15 Feb 2001 05:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRBOKfE>; Thu, 15 Feb 2001 05:35:04 -0500
Received: from colorfullife.com ([216.156.138.34]:58891 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129388AbRBOKfC>;
	Thu, 15 Feb 2001 05:35:02 -0500
Message-ID: <3A8BB0E5.E363F1DE@colorfullife.com>
Date: Thu, 15 Feb 2001 11:35:17 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Cermak <cermak@IMCS.rutgers.edu>
CC: linux-kernel@vger.kernel.org, jonathan_brugge@hotmail.com
Subject: Re: More (other) NIC info/Problem: NIC doesn't work anymore, 
 SIOCIFADDR-errors
In-Reply-To: <Pine.SOL.4.21.0102141940470.3550-100000@imcs.rutgers.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Cermak wrote:
> 
> Anyone who can tell me what's going on here?
>
Perhaps it's the 'dev->memstart==~0' bug I found yesterday?

Could you go into line 450 of 3c509.c and replace

- dev->if_port = (dev->mem_start & 0x1f) ?dev->mem_start & 3: if_port;
+ printk(KERN_WARNING "%s: mem_start is %lxh.\n",dev->name,
dev->mem_start);
+ dev->if_port = if_port;

--
	Manfred
