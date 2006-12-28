Return-Path: <linux-kernel-owner+w=401wt.eu-S964915AbWL1EN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWL1EN4 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 23:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWL1ENz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 23:13:55 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:1550 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964915AbWL1ENz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 23:13:55 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: Re: Oops in 2.6.19.1
Date: Thu, 28 Dec 2006 04:14:20 +0000
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <1167273694.15989.146.camel@ymzhang> <200612280402.23474.s0348365@sms.ed.ac.uk>
In-Reply-To: <200612280402.23474.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612280414.20266.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 December 2006 04:02, Alistair John Strachan wrote:
> On Thursday 28 December 2006 02:41, Zhang, Yanmin wrote:
> [snip]
>
> > > Here's a current decompilation of vmlinux/pipe_poll() from the running
> > > kernel, the addresses have changed slightly. There's no xchg there
> > > either:
> >
> > Could you reproduce the bug by the new kernel, so we could get the exact
> > address and instruction of the bug?
>
> It crashed again, but this time with no output (machine locked solid). To
> be honest, the disassembly looks right (it's like Chuck said, it's jumping
> back half way through an instruction):
>
> c0156f5f:       3b 87 68 01 00 00       cmp    0x168(%edi),%eax
>
> So c0156f60 is 87 68 01 00 00..
>
> This is with the GCC recompile, so it's not a distro problem. It could
> still either be GCC 4.x, or a 2.6.19.1 specific bug, but it's serious.
> 2.6.19 with GCC 3.4.3 is 100% stable.

Looks like a similar crash here:

http://ubuntuforums.org/showthread.php?p=1803389

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
