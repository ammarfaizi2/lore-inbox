Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288565AbSAHX37>; Tue, 8 Jan 2002 18:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288568AbSAHX3k>; Tue, 8 Jan 2002 18:29:40 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:13971 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S288565AbSAHX33>; Tue, 8 Jan 2002 18:29:29 -0500
Date: Tue, 8 Jan 2002 15:28:34 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: i686 SMP systems with more then 12 GB ram with 2.4.x kernel,
 cache buffer bug ?
In-Reply-To: <1010530993.11323.3.camel@hh2.hhhome.at>
Message-ID: <Pine.LNX.4.33.0201081524360.14913-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Jan 2002, Harald Holzer wrote:

> low memory problem:
>
> A Server with 32 GB ram, RH 7.2 and kernel 2.4.17rc2aa2.
> After doing a lot of disc access the system slows down and the system
> dies. Because the system is running out of low memory.
>
> The last kernel logs lines are:
> "kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/0)"
>
> On other kernels then 2.4.17rc2aa2 the oom killer kicks in, or the
> system simply stop responding without any messages.
>
> It looks like that the buffer_heads would fill up the low memory,
> whether there is sufficient memory available or not, as long as
> there is sufficient high memory for caching.
> It seems that the kernel does a good job of releasing dcache or icache,
> but the buffer_heads are filling up the released mem.

In terms of "control knobs", would a limit on page cache size imply a
limit on "buffer_heads", or do we really need the control knob on
"buffer_heads" and not on the page cache? Or would we need both?

-- 
M. Edward "buffer head" Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

What phrase will you *never* hear Candice Bergen use?
"My daddy didn't raise no dummies!"

