Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263442AbUJ2S1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUJ2S1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbUJ2SX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 14:23:29 -0400
Received: from alog0152.analogic.com ([208.224.220.167]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263467AbUJ2SVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:21:32 -0400
Date: Fri, 29 Oct 2004 14:17:53 -0400 (EDT)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Richard Henderson <rth@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
In-Reply-To: <20041029175527.GB25764@redhat.com>
Message-ID: <Pine.LNX.4.61.0410291416040.4844@chaos.analogic.com>
References: <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com>
 <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com>
 <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net>
 <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com>
 <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com>
 <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org>
 <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com> <20041029175527.GB25764@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2004, Richard Henderson wrote:

> On Fri, Oct 29, 2004 at 01:22:52PM -0400, linux-os wrote:
>> Here's a version that uses `leal 4(esp), esp` to add
>> 4 to the stack-pointer. Since this 'address-calculation`
>> is done in an different portion of Intel CPUs....
>
> Incorrect, at least i686 and beyond.  These interpret to the
> same micro-ops.
>
>> The 'pop ecx' would access memory and, therefore be slower than
>> simple register operations.
>
> Also not necessarily correct.  Intel cpus special-case pop
> instructions; two pops can be dual issued, whereas a different
> kind of stack pointer manipulation will not.
>

Then I guess the Intel documentation is incorrect, too.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
