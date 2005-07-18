Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVGRTTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVGRTTf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVGRTTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 15:19:33 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:27840 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261545AbVGRTTc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 15:19:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eb04fKPQBYtGYXmaTqpgN9hIMwKNARUUv10gVLHJJ15oehhYxvXifxYbvxmynEjQbZYYz9kkbYju5djP0jyfQlGGHYpjq6qo0/ucKrjd/igz+mHXoU2ZV6NZKIJ6h524oH9lcnH9fxRN/E7OHoCeJakmIP3ihZKbtnMhhvk3A/Y=
Message-ID: <1e62d137050718121848b5080f@mail.gmail.com>
Date: Tue, 19 Jul 2005 00:18:52 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
Reply-To: Fawad Lateef <fawadlateef@gmail.com>
To: vamsi krishna <vamsi.krishnak@gmail.com>
Subject: Re: Avoiding BIGMEM support programatically.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3faf0568050718075677c13e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf0568050718075677c13e8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/05, vamsi krishna <vamsi.krishnak@gmail.com> wrote:
> Hello All,
> 
> I have a program working fine on a 2.6.xx-smp kernel, and the program
> crashes on the same version kernel with bigmem i.e (2.6.xxx-bigmem).
> 

What is your program ??? what it is doing ??? Can u explain ?? or send
some code portion ?? b/c the BIGMEM kernel and smp/normal kenel has
only a difference of HIGHMEM64G which allows system/kernel on x86 to
use physical memory upto 64GB ..... and enabling this creates
little-bit overhead on the kernel, but I don't think it will effect
the working of most of the kernel modules ......

> I also found that for a same executable on bigmem kernel the virtual
> address's of '&_start' and '&_etext', seem to vary in every new run.
> 

I don't know abt this, so can't say any thing ....

> Is there any way I can avoid the kernel's bigmem virtual address
> mapping programatically? and still run the program on a bigmem kernel?
> 

I think this can be done through specifying GFP_ATOMIC flag in the
memory allocation function, so that it will use ZONE_NORMAL of the
kernel ....... (if i m wrong, then plzz do correct me)

-- 
Fawad Lateef
