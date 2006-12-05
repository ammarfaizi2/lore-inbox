Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968146AbWLEQ70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968146AbWLEQ70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968455AbWLEQ70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:59:26 -0500
Received: from mx0.karneval.cz ([81.27.192.123]:2718 "EHLO av1.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968146AbWLEQ7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:59:25 -0500
Message-ID: <4575A53E.8030403@stud.feec.vutbr.cz>
Date: Tue, 05 Dec 2006 17:58:38 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: IceDove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Jaswinder Singh <jaswinderrajput@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PREEMPT is messing with everyone
References: <aa5953d60612050610l1f2657c3ie073467a2b2a7126@mail.gmail.com>	 <45758B57.6040107@stud.feec.vutbr.cz> <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
In-Reply-To: <aa5953d60612050850v240b382fm172702b1d28934a1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh skrev:
> Yes, Compiler will remove it but this looks ugly and confusing.
> 
> Why dont we use like this :-
> 
> #ifdef CONFIG_PREEMPT
> #include <linux/preempt.h>
> #endif
> 
> #ifdef CONFIG_PREEMPT
>  preempt_disable();
> #endif
> 
> #ifdef CONFIG_PREEMPT
>  preempt_enable();
> #endif

Surely you're joking.
It is much more readable and maintainable to hide the #ifdef-hackery in 
header files than to clutter the *.c files.

Michal

