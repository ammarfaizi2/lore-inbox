Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbRCHASu>; Wed, 7 Mar 2001 19:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRCHASl>; Wed, 7 Mar 2001 19:18:41 -0500
Received: from docs3.abcrs.com ([63.238.77.222]:15876 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S131231AbRCHASa>; Wed, 7 Mar 2001 19:18:30 -0500
Date: Wed, 7 Mar 2001 19:17:17 -0500
Message-Id: <200103080017.TAA24960@mailer.progressive-comp.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Process vs. Threads
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-03-07, "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

> Then for proper ps and top output, you need a reasonably efficient
> way to grab all threads as a group. This could be as simple as
> ensuring that /proc directory reads return related tasks together.
> This works too:   /proc/42/threads/98 -> ../../98

For this (but not for other "proper thread support" things you mention)
would it be enough to have /proc publish some token that represent unique
->fs, ->mm, etc pointers?  (The kernel-space address of each would work,
though that might be leaking too much info; the least userspace must treat
such values as opaque canary tokens.)  This does not give you the most
efficient "ps --threads 231" but it does let ps, top, (fuser?), etc group
processes with the same vm, files, etc, no?  ...I'm kinda surprised such a
thing doesn't already exist actually.  Unless of course, it does exist, but
is not enough :-P

--
Hank Leininger <hlein@progressive-comp.com> 
  
