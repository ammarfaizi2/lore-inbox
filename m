Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269593AbUJLKGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269593AbUJLKGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269594AbUJLKGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:06:01 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:62694 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269593AbUJLKF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:05:59 -0400
Message-ID: <9cde8bff04101203052a711063@mail.gmail.com>
Date: Tue, 12 Oct 2004 19:05:52 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Jan Hudec <bulb@ucw.cz>
Subject: Re: Kernel stack
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
In-Reply-To: <20041012094104.GM703@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com>
	 <46561a790410112351942e735@mail.gmail.com>
	 <20041012094104.GM703@vagabond>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is no SS entry, because SS does not specify the stack. It is siply
> a segment in which the stack lives. Any segment, that covers all address
> space will do! IIRC in kernel SS == DS.
yes, if I am right, in Linux SS, DS and CS all point to the same base
address ( = 0 ?). To be exact, SS !=DS, since the segment registers in
protected mode point to segment selectors (in GDT ?), and we should
compare the value stored GDT entries, not the value of SS and DS in
this case.

> The kernel stack is allocated together with the task_struct. Two pages
> are allocated and task_struct is placed at the start while the stack is
> placed at the end and grows down towards the task_struct.
2 pages of kernel stack or not is optional. Recently version of kernel
allow you to choose to use 4K or 8K size for kernel stack.

>From what you all discuss, I can say: kernel memory is devided into 2
part, and the upper part are shared between processes. The below part
(the kernel stack, or 8K traditionally) is specifict for each process.

Is that right?

Regards,
AQ
