Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbVKQQW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVKQQW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 11:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKQQW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 11:22:26 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:64647 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932394AbVKQQWZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 11:22:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U2figsKeDjsoaXGohe4zKiuEgtwp+FpJW/L5nib7CsEJD9UlvSVPXO4Welv6z5rpigUM0ih46dpdv41kPeejVd7nL43f1CmorLRtNV+eIZSzI9gk3gK1WlX3RBcuMOscFN/bqAaIetnczKbDOSsSVCtqvj3SqxDSimOtx9XYrEI=
Message-ID: <e294b46e0511170822w79e5478asf49183c8447c7c77@mail.gmail.com>
Date: Thu, 17 Nov 2005 16:22:22 +0000
From: Bradley Chapman <kakadu@gmail.com>
To: Bart Samwel <bart@samwel.tk>
Subject: Re: Laptop mode causing writes to wrong sectors?
Cc: linux-kernel@vger.kernel.org, Jan Niehusmann <jan@gondor.com>
In-Reply-To: <437C9334.3020606@samwel.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e294b46e0511170522v5762d48jcaff8413e33b2ebe@mail.gmail.com>
	 <437C9334.3020606@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Samwel,

On 11/17/05, Bart Samwel <bart@samwel.tk> wrote:
>
> OK, that's the second report then. I'm beginning to worry. :/
>
> Are you seeing any DMA timeout messages in your kernel log?

Once, when my /var partition got trashed - about thirty or forty loud
and scary messages from the IDE core saying that various disk accesses
(i.e. normal read/writes) were failing. I do believe DMA was
mentioned.

Another time (i.e. just now), I got five Oopses in a row, most of them
in kmem_cache_alloc() but with one in generic_aio_file_read(). 
Unfortunately I am using fglrx right now so they are probably quite
meaningless...*

Most of the time though, I don't see anything.

Fortunately the number of errors encouraged the kernel to remount R/O,
so after a quick jump to single user mode and two e2fsck -f
invocations, it was healed.

>
> Also, both reports are on ext3, which might point to an ext3 problem
> with long commit intervals.
>
> Bradley, Jan, since when have these problems been happening? Kernel
> version-wise, I mean?

They started with 2.6.13. I can't remember ever expereincing random
partition trashing or random file corruption in 2.6.12. I tried
2.6.14.1 - that kernel did Bad Things as well.

So far though, as long as I stay on juice, 2.6.13 seems to behave.

>
> --Bart
>

Brad

* - http://216.55.161.203/theonekea/misc/oopsen.txt
--
SCREW THE ADS! http://adblock.mozdev.org/
