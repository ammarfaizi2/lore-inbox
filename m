Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVKMRKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVKMRKy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVKMRKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 12:10:54 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24499 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964943AbVKMRKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 12:10:53 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	<20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>
	<Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>
	<4374FB89.6000304@vmware.com>
	<Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>
	<20051113074241.GA29796@redhat.com> <p734q6g4xuc.fsf@verdi.suse.de>
	<1131902775.25311.16.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 13 Nov 2005 10:09:14 -0700
In-Reply-To: <1131902775.25311.16.camel@localhost.localdomain> (Alan Cox's
 message of "Sun, 13 Nov 2005 17:26:15 +0000")
Message-ID: <m1slu0o4p1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2005-11-13 at 11:59 +0100, Andi Kleen wrote:
>> Dave Jones <davej@redhat.com> writes:
>> > 
>> > Looks like the Ubuntu people already did this...
>> > 
>> >
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=048985336e32efe665cddd348e92e4a4a5351415;hp=1cb630c2b5aaad7cedaa78aa135e6cecf5ab91ac
>> 
>> It's probably not needed. At least AMD K7/K8 has a SYSCFG MSR bit to
>> do this (or rather they disable bus cycles for locks that makes them
>> very cheap) Intel has one too in a different MSR that looks similar.
>> With some luck they're even already set by the BIOS on UP systems.  I
>> know they are on some AMD systems.
>
> I'd hope the vendors are not doing that by default because we have
> kernel code that uses lock against not other processors but other bus
> masters. The ECC code is one example. Is there any good info on the AMD
> one so I can make the EDAC code put the processor back in x86 compatible
> mode so that it behaves safely when scrubbing.

Check out the AMD's BIOS and Kernel Programmer Guide for the K8.  The
appropriate bits are documented, although the documentation is quite
terse.

Eric

