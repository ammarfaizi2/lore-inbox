Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJMVVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 17:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbTJMVVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 17:21:35 -0400
Received: from 64-60-75-69.cust.telepacific.net ([64.60.75.69]:48397 "EHLO
	racerx.ixiacom.com") by vger.kernel.org with ESMTP id S261930AbTJMVVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 17:21:34 -0400
Message-ID: <3F8B146E.2020407@ixiacom.com>
Date: Mon, 13 Oct 2003 14:09:02 -0700
From: Dan Kegel <dkegel@ixiacom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: module oops tracking [Re: [PATCH] cheap lookup of symbol names
 on oops()]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In July of 2002, Andrea Arcangeli posted a patch
(see thread http://marc.theaimsgroup.com/?l=linux-kernel&m=102772338115172&w=2)
to dump module names and address ranges during oops logging,
and said that there should eventually be a "module tracking aware ksymoops":

> I implemented what I need to track down oopses with modules. ksymoops
> should learn about it too. This will also allow us to recognize
> immediatly the kernel image used.
> 
> here an example of oops in a module with the patch applied (only 1
> module is affected so only 1 module is listed). I checked that
> 0xca40306e-0xca403060 gives the exact offset to lookup in the objdump -d
> of the module object.
 >
> this patch will solve all the issues in being able to track down module
> oopses and kernel image without introducing any waste of ram (nitpick:
> except 40 bytes of ram). For user compiled kernels, if the user isn't
> capable of saving System.map and vmlinux kksymoops remains a viable
> alternative, but I don't feel it needed for pre-compiled kernel images
> provided a compile-time database exists ...

He has carried that patch forward, and it's e.g. in his current 2.4 tree:
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/90_module-oops-tracking-3

Looking at ksymoops' source and Changelog, it isn't obvious whether
ksymoops-2.4.9 is "module tracking aware" yet.  Has anyone worked
on this?

Thanks,
Dan

