Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTDOOt3 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTDOOt3 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:49:29 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24022 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261631AbTDOOt2 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:49:28 -0400
Message-ID: <3E9C1ED6.9070005@BitWagon.com>
Date: Tue, 15 Apr 2003 08:01:42 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: observe & control thread state for exit futex ?
References: <3E9A2258.9020507@BitWagon.com> <20030414033548.GA4048@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> On Sun, Apr 13, 2003 at 07:52:08PM -0700, John Reiser wrote:
> 
>>How can a debugger, newly attached to an arbitrary thread, determine whether
>>the thread has a pending exit futex and associated memory location to clear
>>[CLONE_CHILD_CLEARTID flag and child_tid_ptr parameter at __clone()]?
>>
>>If so, then how can the debugger determine the address, change the address,
>>cancel the futex, and/or intercept the notification?
> 
> 
> It can't.  Even clone flags are not accessible.
> 
> If you can think of a good reason that a debugger would need any
> particular piece of data, exposing it is very straightforward.
> 

The debugger needs this information to determine the state of the thread.
An automated software audit program needs the information to verify
that threads are working correctly.  In general, write-only state
[from the viewpoint of the thread] is a bad idea.

Would a new option to sys_prctl() be a good way to expose the data?

