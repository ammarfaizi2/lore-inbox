Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319303AbSH2TOr>; Thu, 29 Aug 2002 15:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319304AbSH2TOr>; Thu, 29 Aug 2002 15:14:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:31763 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319303AbSH2TOq>;
	Thu, 29 Aug 2002 15:14:46 -0400
Date: Thu, 29 Aug 2002 12:18:21 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Robert Love <rml@tech9.net>
cc: "Raj, Ashok" <ashok.raj@intel.com>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Stack Limit...
In-Reply-To: <1030648513.978.2601.camel@phantasy>
Message-ID: <Pine.LNX.4.33L2.0208291216160.2567-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Aug 2002, Robert Love wrote:

| On Thu, 2002-08-29 at 15:07, Raj, Ashok wrote:
|
| > Please reply to me, since i dont have this email id on the list.
| >
| > Could someone tell me at what the kernel stack size limit is?
|
| It depends on the architecture.  8KB for x86 and most others.  Some
| (all?) 64-bit platforms have 16KB stacks.
|
| Note the effective size is actually (8KB - sizeof(task_struct)) in 2.4
| and (8KB - sizeof(thread_info)) in 2.5 since those structures are stored
| at the top of the stack.
|
| Also note interrupts share the stack.
|
| > Is there a gcc option for x86 that can warn if too large variables are
| > specified in the stack?
|
| I believe 2.4-ac has a stack overflow check in it... as does the RedHat
| kernel - check it out.
|
| Also kgdb (or at least our copy here at MontaVista) has a stack overflow
| check.

Also Keith Owens posted a script in the last couple of days
that checks stack depth.

-- 
~Randy


