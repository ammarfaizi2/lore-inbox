Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWCaAVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWCaAVb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCaAVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:21:31 -0500
Received: from smtpout.mac.com ([17.250.248.72]:52730 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751166AbWCaAVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:21:30 -0500
In-Reply-To: <20060326065205.d691539c.mrmacman_g4@mac.com>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4B0E79B3-4738-4B6A-82F9-6121E65263EB@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Nix <nix@esperi.org.uk>,
       Rob Landley <rob@landley.net>, Mariusz Mazur <mmazur@kernel.pl>,
       llh-discuss@lists.pld-linux.org, John Livingston <jujutama@comcast.net>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Arch-specific header inconsistency (asm-*/termios.h)
Date: Thu, 30 Mar 2006 19:20:52 -0500
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of cleaning up various headers for use from  
userspace, and at the same time I'm working to clean up some of the  
duplication in the kernel-only portions of those headers.  I'm  
running into one oddity that I can't explain.  In the various asm-*/ 
termios.h files, there are user_termio_to_kernel_termios functions.   
The m68k header does this:

get_user((termios)->c_line, &(termio)->c_line);

The i386 header is missing that line, and after macro expansion the  
rest of the context is almost exactly identical.  It appears there  
are a couple other architectures that fall on both sides of the  
fence.  Can anyone explain this apparently aberrant behavior or is  
this a bug?  If there's a reason behind it, I'll make sure to put in  
a useful comment; otherwise I'll fix it.

Thanks for the help!

Cheers,
Kyle Moffett

