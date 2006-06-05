Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932351AbWFEBDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWFEBDU (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWFEBDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:03:20 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:53914 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932351AbWFEBDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:03:19 -0400
Date: Sun, 4 Jun 2006 20:59:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-rc5-mm1
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        Jan Beulich <jbeulich@novell.com>
Message-ID: <200606042101_MC3-1-C19B-1CF4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44833955.9000104@free.fr>

On Sun, 04 Jun 2006 21:49:41 +0200, Laurent Riffard wrote:

> > Something strange is happening with the stack.  Can you try with 8K stacks?
> > 
> > kernel hacking --->
> >    [ ] Use 4Kb for kernel stacks instead of 8Kb
> > 
> 
> Good catch!

Jan Beulich was the one who noticed the stack overflow.

> I just tried with 2.6.17-rc5-mm3. The BUG still happens with 4K stacks,
> but the system runs fine with 8K stacks.

Can you try -mm3 with "check for stack overflows" and 4k stacks?

> Another info: the system is able to run fine with the following scenario,
> even with 4K stack:
> - boot to runlevel 1
> - load pktcdvd (modprobe + pktsetup)
> - then go to runlevel 5 
> It fails if pktcdvd is loaded at runlevel 2 or higher.

I have no idea why that would happen.

Anyone else have any?

-- 
Chuck

