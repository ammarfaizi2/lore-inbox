Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291625AbSBHQMe>; Fri, 8 Feb 2002 11:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291627AbSBHQMZ>; Fri, 8 Feb 2002 11:12:25 -0500
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:40209 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S291625AbSBHQMM>;
	Fri, 8 Feb 2002 11:12:12 -0500
Date: Fri, 8 Feb 2002 10:13:26 -0600 (CST)
From: Brent Cook <busterb@mail.utexas.edu>
X-X-Sender: busterb@ozma.union.utexas.edu
To: Dave Jones <davej@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fix for duplicate /proc entries
In-Reply-To: <Pine.LNX.4.33.0202072243560.26015-100000@Appserv.suse.de>
Message-ID: <20020208094911.F7930-100000@ozma.union.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Dave Jones wrote:

> On Thu, 7 Feb 2002, Brent Cook wrote:
>
> > I had problems with loading kernel modules more in mind with this patch.
> > Try loading a kernel module that creates a /proc entry and then loading it
> > again with a different name. If the original module that created the /proc
> > entry is then unloaded, any further attempts to read the remaining proc
> > entry leads to a NULL pointer being handed back to the reading process.
>
> "Doctor it hurts when I do this"

I do not think that there are any examples of how checking for duplicate
proc entries is useful at all for correct code. I did not mean to imply
that what I was doing was a smart or useful thing, just that it seemed odd
that it was even possible.

I can't argue that this fixes anything, it just gives proc a more
safety-scissors-like interface. The consequences of not having this check
are not life-threatening obviously. Its really more pedantic, and perhaps
an unnecessary performance penalty for correct code.

Maybe, someday there will be some sort of DEBUG flag to set in the kernel,
from which a slew of asserts and printk's will spring to life, pointing
out inconsistencies and bad assumptions. That is where this check would
probably work the best.

 - Brent Cook


