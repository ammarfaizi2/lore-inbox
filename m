Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVLaA1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVLaA1b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLaA1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:27:31 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:16806 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750782AbVLaA1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:27:30 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mark v Wolher <trilight@ns666.com>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Date: Sat, 31 Dec 2005 00:27:47 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <43B53EAB.3070800@ns666.com> <200512302356.59749.s0348365@sms.ed.ac.uk> <43B5CEB8.9070801@ns666.com>
In-Reply-To: <43B5CEB8.9070801@ns666.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512310027.47757.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 December 2005 00:20, Mark v Wolher wrote:
[snip]
> >
> > This is good news -- you stand a better chance of achieving the stability
> > you require by eliminating variables. VMWare and NVIDIA are useful
> > softwares, and I would not deny that, but they are closed source and thus
> > any conflicts resulting from their use are not necessary LKML material
> > (however, if the interaction is generic and is as a result of a kernel
> > bug, then the maintainer would very much like to hear it).
>
> Okay, i have something interesting now, i only had the nvidia module
> loaded so my x-configuration starts up as usual. (not saying the nvidia
> module is flawless, i'm sure it still contains bugs)
> But here is the crash info, this time it was mozilla, i think this
> speaks more hehe :
>
> Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 061f0c08.
> Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 06b96000.
> Dec 31 00:55:28 localhost kernel: mm/memory.c:106: bad pgd 18000bf8.
> Dec 31 00:55:28 localhost kernel: ------------[ cut here ]------------
> Dec 31 00:55:28 localhost kernel: kernel BUG at mm/mmap.c:2214!
> Dec 31 00:55:28 localhost kernel: invalid operand: 0000 [#1]
> Dec 31 00:55:28 localhost kernel: SMP
> Dec 31 00:55:28 localhost kernel: Modules linked in: nvidia

Steady and sure progress. Now, the trace below doesn't explicitly mention any 
nvidia symbols, but this line must disappear before anybody will bother to 
read your report.

Remove the module. This does not mean unload, this means "never load in the 
first place". Then reproduce the problem. If you are successful, send a new 
email (not pinned to this thread) with a subject a la "kernel BUG at 
mm/mmap.c:2214". State that the kernel is not tainted.

At this point all you can do is wait. Good luck!

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
