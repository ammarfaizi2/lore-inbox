Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbSJ1KQT>; Mon, 28 Oct 2002 05:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262882AbSJ1KQT>; Mon, 28 Oct 2002 05:16:19 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54410 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262865AbSJ1KQR>;
	Mon, 28 Oct 2002 05:16:17 -0500
Date: Mon, 28 Oct 2002 16:05:55 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Skip Ford <skip.ford@verizon.net>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       boissiere@adiglobal.com
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Message-ID: <20021028160555.A7580@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <200210272017.56147.landley@trommello.org> <20021028135504.A7384@in.ibm.com> <200210280955.g9S9tqi3002027@pool-141-150-241-241.delv.east.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210280955.g9S9tqi3002027@pool-141-150-241-241.delv.east.verizon.net>; from skip.ford@verizon.net on Mon, Oct 28, 2002 at 04:55:45AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Skip,

On Mon, Oct 28, 2002 at 04:55:45AM -0500, Skip Ford wrote:
> 
> The first paragraph seems to say that only the base patch is being
> submitted and the watchpoint and user-space extensions can be
> retrieved from the site.
> 
That is not the intention, I will reword that first paragraph on the
website to clarify this.

> But then it goes on to say that you are proposing those for inclusion
> also.  I'm confused and I've been using your patches.  Also, that first
> paragraph mentions "add-on" patches while all along I thought your
> intention was to have enough of dprobes in the kernel so that patching
> wasn't necessary.
> 
Yes, our intention is to have enough of infrastructure in the kernel
to do something like dprobes as an external module without
patching the kernel. 

dprobes provides kernel / user space probes and kernel space 
watchpoints along with an RPN interpreter and communication with
the user space in the form a char device. Now, here is what
various bits of kprobes patches do:

1. kprobes - base patch
   Enables implementing a part of dprobes (kernel space probes)
   without further patching the kernel.

2. debug register management patch
3. kwatch points patch
   Enables implementing another part of dprobes (kernel space 
   watchpoints) without further patching the kernel.

4. user space probes patch
   Enables implementing another part of dprobes (user space 
   probes) without further patching the kernel.

Another point to note is that kprobes should be seen as an independent
facility, a sort of infrastructure on top of which more comprehensive
tools such as dprobes could be built. kprobes infrastructure could
potentially be used in other tools such as kdb/kgdb too.

We would like all four patches to be in the kernel. However, the base
patch has been on the list for a few months, has been looked at and
commented upon by other kernel developers including Rusty and Linus. 
So, we strongly hope for its inclusion. Once kprobes is in, other
patches (notably the user space probes patch) could be considered
a straight forward enhancement to kprobes and may be included
even after the freeze. OTOH if Linus agrees to include all four
patches, that will be great :-)

Thanks for your comments, hope this clarifies the issues.

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
