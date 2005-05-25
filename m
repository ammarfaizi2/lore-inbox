Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVEYX5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVEYX5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 19:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVEYX5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 19:57:31 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:62431 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261617AbVEYX5Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 19:57:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T9f4GIu96u7oblmM0u55YI9HaPylprUs0NZ0DH3FjnUPUtiUL3ZfLbuaYTgcMYSEfZvz0obln5KMPAarttLFAC78TzqmUFoqcfKweTyBlbHBgyG9d+fm5hBFz62XJgrUO8i3PR/O3YyVt78cogN60qSljAneKrkUxFRVT359lCM=
Message-ID: <8783be6605052516577daeebdf@mail.gmail.com>
Date: Wed, 25 May 2005 19:57:23 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Jim Gifford <maillist@jg555.com>
Subject: Re: Random IDE Lock ups with via IDE
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4294E409.9020907@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4293B859.3070609@jg555.com> <4294BAE8.5050803@jg555.com>
	 <8783be6605052513343fce843b@mail.gmail.com>
	 <4294E409.9020907@jg555.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you say the problem started with 2.6.8, perhaps the easiest
thing to do is look at the
kernel you say worked and its config and then just diff it vs 2.6.8.

I took a second look at your original message, and since it's an irq
timeout, it could just be that your drive is slow to answer a command
and then is confused by the error recovery code.  Having two identical
laptops makes this easy.  If your other laptop has the same problem,
then it's software (or buggy hardware that the software hasn't figured
out how to work around) if it doesn't, then it's hardware and there
are a couple of things that can be tweaked to see if it fixes things.

    Ross

On 5/25/05, Jim Gifford <maillist@jg555.com> wrote:
> Ross,
>     I thought of that to, I just have 2 laptops that are identical here
> now. I have placed a different drive in the other one. So we can test
> it, but looking through all my logs that I backed up, this problem
> started when I put 2.6.8 on the laptop. I'm wondering if it could be an
> ACPI issue or IDE issue, but have no idea on what to really look for.
> 
> May 24 16:22:31 laptop kernel: mtrr: 0x40000000,0x800000 overlaps
> existing 0x40000000,0x400000
> May 24 18:25:11 laptop kernel: hda: status timeout: status=0xd0 { Busy }
> May 24 18:25:11 laptop kernel:
> May 24 18:25:11 laptop kernel: ide: failed opcode was: unknown
> May 24 18:25:11 laptop kernel: hda: no DRQ after issuing MULTWRITE
> May 24 18:25:12 laptop kernel: ide0: reset: success
> 
> May 24 12:21:15 laptop2 kernel: mtrr: 0x40000000,0x800000 overlaps
> existing 0x40000000,0x400000
> May 24 16:55:53 laptop2 kernel: hda: status timeout: status=0xd0 { Busy }
> May 24 16:55:53 laptop2 kernel:
> May 24 16:55:54 laptop2 kernel: ide: failed opcode was: unknown
> May 24 16:55:54 laptop2 kernel: hda: no DRQ after issuing MULTWRITE
> May 24 16:55:54 laptop2 kernel: ide0: reset: success
> 
> Here is a link to my .config file
> http://ftp.jg555.com/configs/laptop.config
>
