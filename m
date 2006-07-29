Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWG2SZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWG2SZr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWG2SZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:25:47 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:52387 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932204AbWG2SZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:25:46 -0400
Date: Sat, 29 Jul 2006 12:25:41 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: BIOS detects 4 GB RAM, but kernel does not
In-reply-to: <1154143992.635239.225440@p79g2000cwp.googlegroups.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: iforone <floydstestemail@yahoo.com>
Message-id: <44CBA825.3080609@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <1154112339.037481.119210@p79g2000cwp.googlegroups.com>
 <fa.6TLi9h8OI9J6KX0+lv+D4/CEU0U@ifi.uio.no>
 <fa.adpnQx0XAWgd4+g2tR5HDa2qHDw@ifi.uio.no>
 <1154143992.635239.225440@p79g2000cwp.googlegroups.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iforone wrote:
>> Probably the main reason Intel didn't bother including this support in
>> the desktop boards is that current non-server versions of Windows (at
>> least 32-bit) won't use any memory that is mapped above 4GB anyway even
>> though PAE is enabled - a purely artificial limit that MS put in place
>> to discourage using desktop Windows on such large memory machines..
> 
> Agreed -- I _was_ going to inquire about XP x64 versions, and PAE also,
> and I've read a bit about it (as microshaft has written on it's site),
> but not in quite a while. I recall the semi-related  NoExec (NX) bit
> stuff (though I forgot the mnemonic difference between AMD64 and Intel
> concerning this "bit", which if set disallows execution of any code
> above the 4GB boundary, IIRC).
> 
> to follow-up: Do the XP x64 versions do something else artificially to
> enable addressing up to 16GB of RAM or thereabouts. Or - is it that PAE
> (Physical Address Extensions) stuff again that allows or it?

PAE is what allows an OS in 32-bit mode to access memory located above 
4GB in the address space. On a 64-bit OS the CPU can access all the 
memory directly so PAE is not needed or possible. Also, PAE is often 
enabled on 32-bit systems even with less than 4GB of RAM as it allows 
using the hardware NX bit, which was only added to the PAE versions of 
the 32-bit page tables.

That's a separate issue, though, from the original subject of the thread 
(memory being mapped over by IO space), and from the artificial limit on 
accessing memory above 4GB in at least 32-bit consumer Windows.

> 
> More importantly -- I have (an as-yet-to-be-assembled system) : AMD64
> s754 3000+ with a crappy mATX mobo here (VIA KTm800/8237) Chipset --
> The RAM limit is 2GB total (2 x 1GB DIMM slots only). Do you think this
> el-cheapo mobo would have problems accessing over 4GB *if* the Mobo was
> designed for 4GB ?? IOW-- a Mobo perhaps such as General S uses (MSI,
> ASUStek, etc) -- or do you know if there's something different between
> the s754 and s939 models that I'm unaware of (besides the No Dual
> Channel RAM in s754, since it's only 64bit Single-Channel capable, not
> 128bit).

I don't think most S754 boards support physically installing that much 
RAM, so it may be moot. If you could, you could likely access memory 
above 4GB, though I'm not certain if the S754 CPUs support the memory 
hole remapping to avoid some of that RAM being lost.

> Thanks for the continuing discussion -- I'm glad I didn't follow Intel
> recently and become deceived again - as I'm sure MANY have -- you'd
> think buying a spanking new Pentium-D (8xx) and a 'decent' Intel
> Desktop mobo would allow access to more than 4GB RAM ...but no.... :-(
> (especially when the specs for the mobo claim "4GB" - heck - might as
> well remove 1 x 1GB DIMM, you'd only lose 200MB (yikes)).

Yeah, there is not much point in installing more than 3GB in such a board..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

