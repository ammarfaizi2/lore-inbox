Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263441AbUJ2SDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbUJ2SDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 14:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUJ2R7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:59:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20412 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263382AbUJ2Rzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:55:44 -0400
Date: Fri, 29 Oct 2004 10:55:27 -0700
From: Richard Henderson <rth@redhat.com>
To: linux-os@analogic.com
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
Message-ID: <20041029175527.GB25764@redhat.com>
References: <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:22:52PM -0400, linux-os wrote:
> Here's a version that uses `leal 4(esp), esp` to add
> 4 to the stack-pointer. Since this 'address-calculation`
> is done in an different portion of Intel CPUs....

Incorrect, at least i686 and beyond.  These interpret to the
same micro-ops.

> The 'pop ecx' would access memory and, therefore be slower than
> simple register operations.

Also not necessarily correct.  Intel cpus special-case pop
instructions; two pops can be dual issued, whereas a different
kind of stack pointer manipulation will not.


r~
