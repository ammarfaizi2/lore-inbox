Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263786AbUFFQYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbUFFQYj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbUFFQYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:24:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51898 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263786AbUFFQY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:24:29 -0400
Message-ID: <40C3452B.5010500@pobox.com>
Date: Sun, 06 Jun 2004 12:24:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable scheduler debugging
References: <20040606033238.4e7d72fc.ak@suse.de> <20040606055336.GA15350@elte.hu>
In-Reply-To: <20040606055336.GA15350@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> 
> 
>>The domain scheduler spews out a lot of information at boot up, but it
>>looks mostly redundant because it's just a transformation of what is
>>in /proc/cpuinfo anyways. Also it is well tested now. Disable it.
> 
> 
> i'd rather keep it some more, there are still open issues and if there's
> a boot failure or early crash it makes it easier for us to see the
> actual domain setup. Also, the messages are KERN_DEBUG.


Unfortunately there are just, flat-out, way too many kernel messages at 
boot-up.  Making them KERN_DEBUG doesn't solve the fact that SMP boxes 
often overflow the printk buffer before you boot up to a useful userland 
that can record the dmesg.

The IO-APIC code is a _major_ offender in this area, but the CPU code is 
right up there as well.

	Jeff

