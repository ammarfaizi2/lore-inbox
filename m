Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbQKHXvR>; Wed, 8 Nov 2000 18:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129386AbQKHXu5>; Wed, 8 Nov 2000 18:50:57 -0500
Received: from k2.llnl.gov ([134.9.1.1]:43473 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S129322AbQKHXuz>;
	Wed, 8 Nov 2000 18:50:55 -0500
Message-ID: <3A099F81.81FD885@scs.ch>
Date: Wed, 08 Nov 2000 10:46:25 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: david <sector2@ihug.co.nz>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fpu now a must in kernel
In-Reply-To: <3A09E161.ACB11253@ihug.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you add it to the task switcher, it takes away a lot of cpu cycles
during each task switch and slows down your system. I think this was the
main idea behind _not_ saving those registers. IMHO, it does not make
sense to generally save these registers when nobody else but your driver
uses them. 

Good luck!

Reto

david wrote:
> 
> hi i need fast fpu in the kernel for my lexos work
> so how am i going to do it on the i386
> 
> 1 . can i add some save / restore code to the task swicher ( the right
> way )
>      so when it switchs from user to kernel task its saves the fpu state
> ?
> 
> 2 . put the save / restore code in my code (NOT! GOOD! i do not wont to
> do it this way it is not the right way)
> 
> so i have to use fpu in the kernel so its just how am i going to do it ?
> 
> thank you
> 
>     David Rundle <sector2@ihug.co.nz>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
