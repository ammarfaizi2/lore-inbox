Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUJLMa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUJLMa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266274AbUJLMa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:30:58 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:8093 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266186AbUJLMay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:30:54 -0400
Message-ID: <9cde8bff04101205302834206@mail.gmail.com>
Date: Tue, 12 Oct 2004 21:30:54 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Jan Hudec <bulb@ucw.cz>
Subject: Re: Kernel stack
Cc: suthambhara nagaraj <suthambhara@gmail.com>,
       "Dhiman, Gaurav" <gaurav.dhiman@ca.com>,
       main kernel <linux-kernel@vger.kernel.org>,
       kernel <kernelnewbies@nl.linux.org>
In-Reply-To: <20041012102731.GQ703@vagabond>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <577528CFDFEFA643B3324B88812B57FE3055B9@inhyms21.ca.com>
	 <46561a790410112351942e735@mail.gmail.com>
	 <20041012094104.GM703@vagabond>
	 <9cde8bff04101203052a711063@mail.gmail.com>
	 <20041012102731.GQ703@vagabond>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >From what you all discuss, I can say: kernel memory is devided into 2
> > part, and the upper part are shared between processes. The below part
> > (the kernel stack, or 8K traditionally) is specifict for each process.
> >
> > Is that right?
> 
> No, it's not. There is just one kernel memory. In it each process has
> it's own task_struct + kernel stack (by default 8K). There is no special
> address mapping for these, nor are they allocated from a special area.
> 
> When a context of some process is entered, esp is pointed to the top of
> it's stack. That's exactly all it takes to exchange stacks.

OK, lets say there are 20 processes running in the system. Then the
kernel must allocate 20 * 8K = 160K just for the stacks of these
processes. All of these 160K always occupy the kernel (kernel memory
is never swapped out). When a process actives, ESP would switch to
point to the corresponding stack (of that process).

The remainding memory of kernel therefore is equally accessible to all
the processes.

Is that correct ?

Thank you,
AQ
