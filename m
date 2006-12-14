Return-Path: <linux-kernel-owner+w=401wt.eu-S932368AbWLNKs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWLNKs6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWLNKs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:48:58 -0500
Received: from il.qumranet.com ([62.219.232.206]:53131 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932368AbWLNKs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:48:57 -0500
Message-ID: <45812C17.4090309@argo.co.il>
Date: Thu, 14 Dec 2006 12:48:55 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il> <200612141125.14777.hjk@linutronix.de>
In-Reply-To: <200612141125.14777.hjk@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[why trim the cc?]

Hans-Jürgen Koch wrote:
> Am Donnerstag, 14. Dezember 2006 10:44 schrieb Avi Kivity:
>
>   
>> I understand one still has to write a kernel driver to shut up the irq.  
>> How about writing a small bytecode interpreter to make event than 
>> unnecessary?
>>
>> The userspace driver would register a couple of bytecode programs: 
>> is_interrupt_pending() and disable_interrupt(), which the uio framework 
>> would call when the interrupt fires.
>>
>> The bytecode could reuse net/core/filter.c, with the packet replaced by 
>> the mmio or ioregion, or use something new.
>>
>>     
>
> I think this would be overkill. The kernel module you have to write
> is _really_ very simple. And it has to be written only once, so even
> a manufacturer who employs no experienced kernel developers can
> easily outsource that task.
>
>   

It has to be written once, but compiled for every kernel version and 
$arch out there (for out of tree drivers), or it has to wait for the 
next kernel release and distro sync (for in-tree drivers).

If we make userspace drivers possible, it makes sense that the entire 
driver be in userspace, not just 98.7% of it.



-- 
error compiling committee.c: too many arguments to function

