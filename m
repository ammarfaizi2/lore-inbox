Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbRDDVX6>; Wed, 4 Apr 2001 17:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132481AbRDDVXt>; Wed, 4 Apr 2001 17:23:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17025 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132478AbRDDVXg> convert rfc822-to-8bit; Wed, 4 Apr 2001 17:23:36 -0400
Date: Wed, 4 Apr 2001 17:22:20 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Walberg <tewalberg@mediaone.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel/sched.c questions
In-Reply-To: <20010404150833.C28474@mediaone.net>
Message-ID: <Pine.LNX.3.95.1010404170239.4737B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, Tim Walberg wrote:

> On 04/04/2001 16:52 -0300, Sardañons, Eliel wrote:
> >>	Hello, I would like to know why you put this two functions:
> >>	void scheduling_functions_start_here(void) { }
> >>	...
> >>	void scheduling_functions_end_here(void) { }
> >>	
> 

This is so 'ps' knows if somebody is sleeping in the scheduler,
which is most often the case unless you have 2 or more CPUs.
When these addresses are found, the observed stack is unwound
to find the return address, hense where the sleeping task
was really sleeping.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


