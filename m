Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266589AbRGEBDb>; Wed, 4 Jul 2001 21:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266596AbRGEBDV>; Wed, 4 Jul 2001 21:03:21 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:51209 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S266589AbRGEBDH>; Wed, 4 Jul 2001 21:03:07 -0400
Date: Wed, 4 Jul 2001 21:02:27 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010704210227.A19675@munchkin.spectacle-pond.org>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107040337.XAA00376@smarty.smart.net>; from humbubba@smarty.smart.net on Tue, Jul 03, 2001 at 11:37:28PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 11:37:28PM -0400, Rick Hohensee wrote:
> That's with the GNU tools, without asm(), and without proper declaration
> of printf, as is my tendency. I don't actually return an int either, do I?
> LAAETTR.

Under ISO C rules, this is illegal, since you must have a proper prototype in
scope when calling variable argument functions.  In fact, I have worked on
several GCC ports, where the compiler uses a different calling sequence for
variable argument functions than it does for normal functions.  For example, on
the Mips, if the first argument is floating point and the number of arguments
is not variable, it is passed in a FP register, instead of an integer
register.  For variable argument functions, everything is passed in the integer
registers.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
