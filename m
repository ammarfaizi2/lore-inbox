Return-Path: <linux-kernel-owner+w=401wt.eu-S1753609AbWL0TKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbWL0TKy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 14:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754684AbWL0TKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 14:10:53 -0500
Received: from tapsys.com ([72.36.178.242]:44246 "EHLO tapsys.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753731AbWL0TKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 14:10:53 -0500
X-Greylist: delayed 1273 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Dec 2006 14:10:53 EST
Message-ID: <4592C038.8010407@madrabbit.org>
Date: Wed, 27 Dec 2006 10:49:28 -0800
From: Ray Lee <ray-lk@madrabbit.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, ray-gmail@madrabbit.org,
       linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
Subject: Re: Feature request: exec self for NOMMU.
References: <200612261823.07927.rob@landley.net> <200612270051.52690.rob@landley.net> <1167199716.5616.3.camel@localhost.localdomain> <200612270329.16320.rob@landley.net>
In-Reply-To: <200612270329.16320.rob@landley.net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 27 December 2006 1:08 am, Vadim Lobanov wrote:
>> On Wed, 2006-12-27 at 00:51 -0500, Rob Landley wrote:
>>> On Wednesday 27 December 2006 12:13 am, Ray Lee wrote:
>>>> How about openning an fd to yourself at the beginning of execution, then
>>>> calling fexecve later?
>>> I haven't got a man page for fexecve.  Does libc have it?
>> It's implemented inside glibc, and uses /proc to execve() the file that
>> the fd points to.

Oh, hmm. Then I think it won't work, will it? I'd assumed fexecve was
implemented in kernel.

> Cute, and I can do that.  Assuming /proc is mounted in the chroot 
> environment...

Maybe I'm just confused -- wouldn't be the first time -- but if it's
implemented inside userspace, then once you chroot() you won't be able
to execute the path you find via /proc, will you?
