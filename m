Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275621AbRJJMiD>; Wed, 10 Oct 2001 08:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275661AbRJJMhx>; Wed, 10 Oct 2001 08:37:53 -0400
Received: from sushi.toad.net ([162.33.130.105]:54500 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S275621AbRJJMhk>;
	Wed, 10 Oct 2001 08:37:40 -0400
Subject: Re: sysctl interface to bootflags?
From: Thomas Hood <jdthood@mail.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110100844340.26743-100000@Appserv.suse.de>
In-Reply-To: <Pine.LNX.4.30.0110100844340.26743-100000@Appserv.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 10 Oct 2001 08:37:23 -0400
Message-Id: <1002717445.5284.39.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-10 at 02:46, Dave Jones wrote:

> Ouch. Can you verify that the CMOS register its changing matches
> with what's listed in the BOOT record ?
> add a printk to bootflag.c to check.

I haven't rebooted since this happened; the error
occurred when I resumed from hibernation.

In any case, I suspect that the BIOS reset whatever
register it was that was incorrectly set.  Here again
is the output of the sbf program that cause the problem.
I ran the "sbf-0.3" version of the program, modified
to ignore the parity error on the value read back from the
register.

root@thanatos:/home/jdthood/src/sbf# ./a.out
BOOT @ 0x07fd0040
CMOS register: 0x33
Read current value := 0x88
Read updated value := 0x89

We need to come to a better understanding of what it's doing
differently from bootflag.c, which writes to the right place.

Regards
Thomas



