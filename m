Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRIJFJW>; Mon, 10 Sep 2001 01:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273205AbRIJFJN>; Mon, 10 Sep 2001 01:09:13 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:16918 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273204AbRIJFJF>; Mon, 10 Sep 2001 01:09:05 -0400
Subject: Re: Feedback on preemptible kernel patch
From: Robert Love <rml@tech9.net>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Arjan Filius <iafilius@xs4all.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20010910031728Z16177-26183+705@humbolt.nl.linux.org>
In-Reply-To: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet>
	<1000071474.16805.20.camel@phantasy> 
	<20010910031728Z16177-26183+705@humbolt.nl.linux.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.08.07.08 (Preview Release)
Date: 10 Sep 2001 01:09:52 -0400
Message-Id: <1000098594.18895.1.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-09 at 23:24, Daniel Phillips wrote:
> This may not be your fault.  It's a GFP_NOFS recursive allocation - this
> comes either from grow_buffers or ReiserFS, probably the former.  In
> either case, it means we ran completely out of free pages, even though
> the caller is willing to wait.  Hmm.  It smells like a loophole in vm
> scanning.

I am not a VM hacker -- can you tell me where to start? what do you
suspect it is?

If the user stops seeing the error with preemption disabled, is your
theory nulled, or does that just mean the problem is agitated by
preemption?

I don't think Arjan was using ReiserFS, so its from grow_buffers...

I appreciate your help.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

