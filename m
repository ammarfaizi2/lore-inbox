Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUJORFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUJORFn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 13:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268232AbUJORFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 13:05:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268199AbUJORBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 13:01:37 -0400
Date: Fri, 15 Oct 2004 12:59:50 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Josh Boyer <jdub@us.ibm.com>
cc: gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
Subject: Re: Fw: signed kernel modules?
In-Reply-To: <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
Message-ID: <Pine.LNX.4.61.0410151237360.6239@chaos.analogic.com>
References: <27277.1097702318@redhat.com>  <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
  <1097843492.29988.6.camel@weaponx.rchland.ibm.com> 
 <200410151153.08527.gene.heskett@verizon.net> <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Josh Boyer wrote:

> On Fri, 2004-10-15 at 10:53, Gene Heskett wrote:
>>>
>>> cd linux-2.6;
>>> patch -R -p1 < ../<modsign patch name>
>>>
>>> josh
>>>
>> Yes, but what happens if it gets into the tarballs from kernel.org.
>>
>> Stop this nonsense Linus, now.
>
> While my original post was more of a symbolic "I think you're being a
> bit over-dramatic" response, it's still valid once it's in a tarball
> too.  A tarball is just source that has the patch applied...
>
> I personally don't see anything wrong with concept of signed modules.
> Make it a config option and call it good.  I'd probably never run with
> signed modules with a kernel I built myself, but that's my choice.
> Others can choose differently.
>
> Let's separate the technical details from the opinions about whether
> such a feature will end the free world as we know it or not.  (Which it
> won't).
>
> josh
>

The technical details are that "signed", "sealed", "certified",
relate to policy. For years policy was not allowed to be included in
the kernel. In recent times, the kernel has become filthy with
policy.

For instance, a simple module that implements open/close has this

00000000 r __mod_license23
00000047 r __module_depends
00000020 r __mod_vermagic5
00000000 D __this_module
00000000 r ____versions

... used to enforce somebody's policy (whoever wrote the latest
module code), not your policy nor my policy, just someone's policy
which becomes the de-facto kernel "law". That's why there must
not be policy in the kernel because it's not possible to get
it right. What's right for you is wrong for another.

We let this start when there were problems with secret video
modules. Nobody wanted to debug a kernel that could be corrupted
by a module where nobody could read the source-code. So if there
isn't a MODULE_LICENSE("POLICY") then a 'tainted' mark goes
in any OOPS report. Well, they got away with that. It was
explained away as being "good" policy. Now they are making
more policy.

And, yes, the end-of-the-world-as-we-know-it, comes one interval
at a time.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

