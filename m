Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266043AbTBOVBj>; Sat, 15 Feb 2003 16:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTBOVBj>; Sat, 15 Feb 2003 16:01:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:29833 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266043AbTBOVBh>; Sat, 15 Feb 2003 16:01:37 -0500
Date: Sat, 15 Feb 2003 13:11:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with 2.5.61-mm1
Message-ID: <6190000.1045343484@[10.10.2.4]>
In-Reply-To: <3E4E8B41.6080609@us.ibm.com>
References: <3E4E0153.3000008@us.ibm.com> <92090000.1045333203@[10.10.2.4]>
 <3E4E8B41.6080609@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> No, that's a kirq broke no_irq_balance thing (I presume this is NUMA-Q?).
> 
> Nope, it's an 8-way Summit box.
> 
> I just booted 2.5.61, and the problem still happens there, so it not
> surprisingly isn't just -mm.

Ah, OK. Sorry, "assumptions > coffee" error.
 
>> There's a bootflag option to disable it as well, but that's broken too. I
>> can't fix do it right now, but someone needs to go through and fix all
>> the disable bits so they work.
> 
> Disabling it is easy.  Any idea what might be wrong.

Yup, lots of the code assumes things are in flat logical mode, and/or
that you can target arbitrary bitmasks of CPUs ... see the fix I sent out
yesterday for smp_affinity, for instance.

M.

