Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTE2PoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTE2PoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 11:44:21 -0400
Received: from wmail.atlantic.net ([209.208.0.84]:64726 "HELO
	wmail.atlantic.net") by vger.kernel.org with SMTP id S262336AbTE2PoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 11:44:17 -0400
Message-ID: <3ED63032.3030702@techsource.com>
Date: Thu, 29 May 2003 12:07:14 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ed L Cashin <ecashin@uga.edu>
CC: linux-kernel@vger.kernel.org, Jim Houston <jim.houston@attbi.com>
Subject: Re: signal queue resource - Posix timers
References: <200305281856.h4SIuFZ02449@linux.local>	<20030529014608.GX8978@holomorphy.com> <87y90q1fxm.fsf@cs.uga.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ed L Cashin wrote:
> William Lee Irwin III <wli@holomorphy.com> writes:
> 
> 
>>
>>Well, I've never run into it and it sounds really obscure, but I agree
>>in principle that it's better to return an explicit error to userspace
>>than to silently fail, at least when it's feasible (obviously the kernel
>>can be beaten to death with events faster than it can deliver them, so
>>it won't always be feasible).
> 
> 
> Why couldn't this be a configurable per-user thing like RSS rlimits?
> 

Pardon me for butting in...

It seems to me that returning an error on unrecoverable failure is 
ALWAYS the right thing to do.

We're not doing that right now, and that's okay.  We can simply admit 
that we're not quite doing the right thing and get around to fixing it 
later.

But once the fix has been made, why would anyone want it to be optional? 
  Is it so rare an event that the performance hit isn't worth the 
catastrophe which might occur if we don't properly return an error?

