Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUAPJ2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 04:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbUAPJ2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 04:28:33 -0500
Received: from gate.in-addr.de ([212.8.193.158]:30408 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265333AbUAPJ23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 04:28:29 -0500
Date: Fri, 16 Jan 2004 10:24:47 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>, Neil Brown <neilb@cse.unsw.edu.au>
Cc: Scott Long <scott_long@adaptec.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: Proposed enhancements to MD
Message-ID: <20040116092447.GF22417@marowsky-bree.de>
References: <40033D02.8000207@adaptec.com> <16389.52150.148792.875315@notabene.cse.unsw.edu.au> <20040115155221.A31378@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040115155221.A31378@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-01-15T15:52:21,
   Matt Domsch <Matt_Domsch@dell.com> said:

> * Solution works in both 2.4 and 2.6 kernels
>   - less ideal of two different solutions are needed

Sure, this is important.

> * RAID 0,1 DDF format
> * Bootable from degraded R1

We were looking at extending the boot loader (grub/lilo) to have
additional support for R1 & multipath. (ie, booting from the first
drive/path in the set where a consistent image can be read.) If the BIOS
supports DDF too, this would get even better.

For the boot drive, this is highly desireable!

Do you know whether DDF can also support simple multipathing?

> * Boot from degraded RAID1 requires setup method early in boot
>   process, either initrd or kernel code.

This is needed with DDF too; we need to parse the DDF data somewhere
afterall.

> From what I see about md:
> * RAID 0,1 there today, no DDF

Supporting additional metadata is desireable. For 2.6, this is already
in the code, and I am looking forward to having this feature.

> Am I way off base here? :-)

I don't think so. But for 2.6, the functionality should go either into
DM or MD, not into emd. I don't care which, really, both sides have good
arguments, none of which _really_ matter from a user-perspective ;-)

(If, in 2.7 time, we rip out MD and fully integrate it all into DM, then
we can see further.)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	      \ ever tried. ever failed. no matter.
SUSE Labs			      | try again. fail again. fail better.
Research & Development, SUSE LINUX AG \ 	-- Samuel Beckett

