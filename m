Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTJJM2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 08:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTJJM2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 08:28:18 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:8331 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id S261906AbTJJM2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 08:28:17 -0400
Date: Fri, 10 Oct 2003 05:27:55 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010122755.GC22908@ca-server1.us.oracle.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <16261.56894.8109.858323@charged.uio.no> <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310091525200.20936-100000@home.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 09, 2003 at 03:26:47PM -0700, Linus Torvalds wrote:
> User space shouldn't know or care about frsize, and it doesn't even 
> necessarily make any sense on a lot of filesystems, so make it easy for 
> the user. It's not as if the rounding errors really matter.

	User space has to know about frsize for O_DIRECT alignment.
Some times you just want to write the 512 B you have in hand, not have to
read-modify-write the n KB around it.  frsize is much nicer that hunting
up the appropriate block device to BLKSSZGET on .


Joel


-- 

"I have never let my schooling interfere with my education."
        - Mark Twain

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
