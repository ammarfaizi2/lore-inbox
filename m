Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVADAYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVADAYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 19:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVADAWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 19:22:53 -0500
Received: from p-nya.swiftel.com.au ([202.154.106.98]:43185 "EHLO
	famine.coesta.com") by vger.kernel.org with ESMTP id S262010AbVADAUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 19:20:41 -0500
Message-ID: <45567.202.154.120.74.1104797829.squirrel@www.coesta.com>
In-Reply-To: <20050103221516.GV29332@holomorphy.com>
References: <44438.202.154.120.74.1104760841.squirrel@www.coesta.com>
    <20050103221516.GV29332@holomorphy.com>
Date: Tue, 4 Jan 2005 08:17:09 +0800 (WST)
Subject: Re: Max CPUs on x86_64 under 2.6.x
From: "Colin Coe" <colin@coesta.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Reply-To: colin@coesta.com
User-Agent: SquirrelMail/1.4.3a-6.FC3
X-Mailer: SquirrelMail/1.4.3a-6.FC3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 03, 2005 at 10:00:41PM +0800, Colin Coe wrote:
>> Why is the number of CPUs on the x86_64 architecture only 8 but under
>> i386
>> it is 255?
>> I've searched the list archives and Google but can't find an answer.
>
> i386 machines have had interrupt controllers and "large scale" systems
> (to the extent that 32-bit machines can be so) developed for some time.
> x86-64 machines are newer, and it is the maintainer's preference to
> start with a fresh codebase for the APIC.
>
> So what you see is not a reflection of x86-64's capabilities, but
> rather, of the newness of the architecture and the codebase's desire
> to be "legacy-free" in manners that don't pose the threat of causing
> immediate problems.
>
> It is not now limiting the capabilities of x86-64 machines because
> x86-64 machines of 64 cpus or larger have yet to be produced. For the
> record, I'm unaware of SSI i386 machines larger than 64 processors.
> 255 represents nothing more than a theoretical limit of hardware
> capabilities, and no i386 machine larger than 64 processors has ever
> been constructed to the best of my knowledge.
>
>
> -- wli
>

Hi and thanks for the response.

Just one more question, what is the '64 cpus' that you are referring to? 
The ./arch/x86_64/Kconfig file states:
---
# actually 64 maximum, but you need to fix the APIC code first
# to use clustered mode or whatever your big iron needs
config NR_CPUS
        int "Maximum number of CPUs (2-8)"
        range 2 8
        depends on SMP
        default "8"
        help
          This allows you to specify the maximum number of CPUs which this
          kernel will support.  The maximum supported value is 32 and the
          minimum value which makes sense is 2.

          This is purely to save memory - each supported CPU requires
          memory in the static kernel configuration.
---
Can you clarify this as:
- the comments says 64 CPUs,
- the code says 8 CPUs, and
- the help text says 32 CPUs.

The company I work for is looking at IBM x445 servers which support up to
32 processors (although this is via NUMA-Q).  Are NUMA-Q boxes also
subject to the 8 CPU limit?

Thanks

CC
