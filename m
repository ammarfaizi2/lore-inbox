Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTHUBNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbTHUBNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:13:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:35990 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262373AbTHUBNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:13:45 -0400
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Date: Wed, 20 Aug 2003 20:13:51 -0500
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200308201658.05433.habanero@us.ibm.com> <1061427779.9371.318.camel@nighthawk>
In-Reply-To: <1061427779.9371.318.camel@nighthawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308202013.51702.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 August 2003 20:02, Dave Hansen wrote:
> On Wed, 2003-08-20 at 14:58, Andrew Theurer wrote:
> > Maybe this is already known, but just in case:
> > I cannot fully boot on an x440 system with 2.6.0-test3-bk8.  The kernel
> > tries to boot more than the 16 logical processors, and after failing (no
> > response) on cpus 16, 17, and 18, it still thinks it has 19 cpus total. 
> > It finally gets stuck at "checking TSC synchronization across 19 CPUs:"
> >
> > Attached is the boot log.  Any ideas? I'll try -test3-bk7 next
>
> Can you see if it works without HT on?  Did it work on plain -test3?
> My 16-way x440 with no HT boots fine on test3.

I'll try without HT to see what happens.  FWIW, it boots fine with HT if I set 
maxcpus=16.  I am wondering if (apicid == BAD_APIC) test is not working in 
smp_boot_cpus.

-Andrew Theurer

