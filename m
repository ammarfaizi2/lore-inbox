Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266035AbUGAQhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUGAQhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUGAQhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:37:40 -0400
Received: from waste.org ([209.173.204.2]:19867 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S266035AbUGAQhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:37:37 -0400
Date: Thu, 1 Jul 2004 11:37:27 -0500
From: Matt Mackall <mpm@selenic.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       lkml List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701163726.GH5414@waste.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org> <00345FCC-CB11-11D8-947A-000393ACC76E@mac.com> <20040701041158.GE1564@mail.shareable.org> <736E7483-CB1B-11D8-947A-000393ACC76E@mac.com> <20040701123941.GC4187@mail.shareable.org> <F64265B6-CB6C-11D8-947A-000393ACC76E@mac.com> <20040701145004.GA5114@mail.shareable.org> <9628EAFE-CB6F-11D8-947A-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9628EAFE-CB6F-11D8-947A-000393ACC76E@mac.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 11:01:52AM -0400, Kyle Moffett wrote:
> On Jul 01, 2004, at 10:50, Jamie Lokier wrote:
> >Kyle Moffett wrote:
> >>>The error code is -1, aka. MAP_FAILED.
> >>Oops!  I guess I was just lucky that part didn't fail :-D On the
> >>other hand, it couldn't legally return 0 anyway, could it?
> >
> >Yes it could -- if you request a mapping at address 0 with MAP_FIXED.
> >A few OSes won't do that, but Linux and many others will.
> 
> That allows untrapped dereferencing of a NULL pointer.  IMHO, that
> would be a very unintelligent thing for a program to do, to deny itself
> the bug-catching features provided therein, but it's interesting to see
> that it is possible.

A typical use is vm86-based emulation of 16-bit DOS where there's data
in the immediate vicinity of NULL.

-- 
Mathematics is the supreme nostalgia of our time.
