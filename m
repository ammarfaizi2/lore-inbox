Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSCNQS1>; Thu, 14 Mar 2002 11:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311654AbSCNQSU>; Thu, 14 Mar 2002 11:18:20 -0500
Received: from zeus.kernel.org ([204.152.189.113]:20431 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311650AbSCNQSE>;
	Thu, 14 Mar 2002 11:18:04 -0500
Date: Thu, 14 Mar 2002 17:13:00 +0100
From: Dave Jones <davej@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020314171300.H19636@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Bill Davidsen <davidsen@tmr.com>, Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020314133223.B19636@suse.de> <Pine.LNX.3.96.1020314104230.9248A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1020314104230.9248A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Thu, Mar 14, 2002 at 10:53:01AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:53:01AM -0500, Bill Davidsen wrote:
 
 >   Since vendors (and consultants) like to build a single kernel for use on
 > multiple machines, it would be nice if this could be done by some init
 > code (released) and a module. 
 
 The relevant code is (where possible) marked as __init already.
 So the init code gets thrown away whether needed or not.
 
 >   The code actually looks so small as to be unworthy of an option
 
 It's not a matter of codesize, it's a correctness issue in the source.
 #ifndef CONFIG_M686 is wrong. It assumes a P6 is the only CPU family
 in existence without the bug, despite the fact there are probably close
 to a dozen others.

 > that many people would set it off not knowing was it was much less whether
 > they needed it. This is not like a missing FPU where you can do a graceful
 > reject of the instructions, if you have the bug and not the fix you are
 > vulnerable to sudden total failures, correct?

 No. You at worse vulnerable to a malicious user running hand-crafted code
 (no compiler generates this code-sequence) bringing down the machine.

 The proposal however was not to remove anything that we currently have.
 Every kernel that is possible to be run on an affected box (i386/i486/i586)
 would still have the workaround present. We just won't generate it in
 Cyrix III, Athlon, Pentium 4, etc kernels..


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
