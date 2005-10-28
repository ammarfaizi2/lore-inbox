Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbVJ1Tat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbVJ1Tat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbVJ1Tat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:30:49 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:38784 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1751669AbVJ1Tas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:30:48 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: AMD Athlon64 X2 Dual-core and 4GB
Date: Fri, 28 Oct 2005 19:30:46 +0000 (UTC)
Organization: Cistron
Message-ID: <djtu96$r99$1@news.cistron.nl>
References: <4361408B.60903@lazarenko.net> <20051028160403.GA26286@hockin.org> <43625484.30100@lazarenko.net> <m11x25bn3j.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1130527846 27945 194.109.0.112 (28 Oct 2005 19:30:46 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@zahadum.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m11x25bn3j.fsf@ebiederm.dsl.xmission.com>,
Eric W. Biederman <ebiederm@xmission.com> wrote:
>Vladimir Lazarenko <vlad@lazarenko.net> writes:
>
>>>>>Thus, the question - would I be able to use whole 4G RAM with dual-core amd
>> and
>>>>>kernel with SMP compiled for i686?
>>> Why would you use a dual core AMD in 32 bit mode?  Just build an x86_64
>>> kernel.
>>> If you want to use 4GB in 32 bit mode, you *need* remapping (or you lose
>>> part of your memory).  Remapping means you have MORE than 4 GB of physical
>>> address, which means you need PAE to use it at all.
>>
>> Because I find my distribution's 64-bit release reasonably unstable yet? :)
>>
>> Or can I somehow build an x86_64 kernel and keep using 32-bit libc?
>
>Building a x86_64 kernel is a bit of a trick on a 32bit distro.  
>You need an appropriate version of gcc, and binutils.  But it runs
>fine.

I installed the 64 bit version of my distro on a small partition,
the 32 bit version on a larger partition. Then I compiled a kernel
on the 64 bit system, and installed it on the 32 bit partition.

Now I boot a 64 bit kernel for the 32 bit userland, and mount the
64-bit distribution partition under /amd64 - if I need to do
anything in 64 bit userland (like compile a new kernel) I just
chroot /amd64

Even the 64-bit binary nvidia kernel driver works fine with
a 32-bit X in userland.

Mike.

