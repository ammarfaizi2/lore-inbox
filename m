Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbTELPJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTELPJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:09:11 -0400
Received: from franka.aracnet.com ([216.99.193.44]:34709 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262210AbTELPJK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:09:10 -0400
Date: Mon, 12 May 2003 06:07:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>, haveblue@us.ibm.com
Subject: Re: 2.5.69-mjb1
Message-ID: <23510000.1052744845@[10.10.2.4]>
In-Reply-To: <20030512150309.GG19053@holomorphy.com>
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <20030512150309.GG19053@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Me
>>> Can I get some sort of vague explanation please? ;-)
>
> Bill
> How obvious does it have to be?

More obvious than that, if I've never looked at it before ;-)

> Dave
> They're trying to access the variables that have been pushed onto the
> top of the stack.  The thread_info field points to the bottom of the
> kernel's stack (no matter how big it is).  I don't know where the -5 and
> -2 come from.  It needs a big, fat stinking comment.

OK, so maybe I'm still asleep, but I don't see why the hardcoded
magic constant (grrr) is 4096 in mainline, when the stacksize is 8K.
Presumably the 1019*4 makes up the rest of it? Maybe the real question 
is what the hell was whoever wrote that in the first place smoking ? ;-)
Why on earth would you skip halfway through the stack with one stupid 
magic constant, and then the rest of the way with another? 

Perhaps I'm just making the mistake of assuming the existing code was
sane ... I was just uncomfortable because I didn't understand why it was
like that before, I guess.

> Dave
> I don't know where the -5 and
> -2 come from.  It needs a big, fat stinking comment.
>
> Bill
> Those are trying to fish out the 2nd and 5th words from the top of the
> stack. Magic numbers stopped working; symbolic constants save the day.

Right, I see what you're doing now. 

But would be nice (as Dave said) if those magic numbers were no longer
magic numbers (as you did for the other part of it), if that's possible,
or commented. Not that you haven't vastly improved it already ;-)

Thanks,

M.

