Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271415AbTHDIyw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 04:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271418AbTHDIyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 04:54:52 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:46751 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S271415AbTHDIyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 04:54:51 -0400
Message-ID: <3F2E1F7B.3020906@softhome.net>
Date: Mon, 04 Aug 2003 10:55:23 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: TOE brain dump
References: <g83n.8vu.9@gated-at.bofh.it> <3F2CFC80.4090401@softhome.net> <20030803151000.D10280@almesberger.net>
In-Reply-To: <20030803151000.D10280@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Ihar 'Philips' Filipau wrote:
> 
>>    Modern NPUs generally do this.
> 
> 
> Unfortunately, they don't - they run *some* code, but that
> is rarely a Linux kernel, or a substantial part of it.
> 

   Embedded CPU we are using is based MIPS, and has a lot of specialized 
instructions.
   It makes not that much sense to run kernel (especially Linux) on CPU 
which is optimized for handling of network packets. (And has actually 
several co-processors to help in this task).
   How much sense it makes to run general purpose OS (optimized for PCs 
and servers) on devices which can make only couple of functions? (and no 
MMU btw)

   It is a whole idea behind this kind of CPUs - to do a few of 
functions - but to do them good.

   If you will start stretching CPUs like this to fit Linux kernel - it 
will generally just increase price. Probably there are some markets 
which can afford this.

   Remeber - "Small is beatiful" (c) - and linux kernel far from it.
   Our routing code which handles two GE interfaces (actually not pure 
GE, but up to 2.5GB) fits into 3k. 3k of code - and that's it. not 650kb 
of bzip compressed bloat. And it handles two interfaces, handles fast 
data path from siblign interfaces, handles up to 1E6 routes. 3k of code. 
not 650k of bzip.

