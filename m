Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264010AbSKTXgB>; Wed, 20 Nov 2002 18:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSKTXgB>; Wed, 20 Nov 2002 18:36:01 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:12563 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S264010AbSKTXf4>; Wed, 20 Nov 2002 18:35:56 -0500
Date: Thu, 21 Nov 2002 10:41:37 +1100
From: john slee <indigoid@higherplane.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Ledford <dledford@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why /dev/sdc1 doesn't show up...
Message-ID: <20021120234137.GA7915@higherplane.net>
References: <20021119055636.94C182C088@lists.samba.org> <20021119160622.GA8738@redhat.com> <3DDA7B08.7010101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDA7B08.7010101@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ cc trimmed a-plenty ]

On Tue, Nov 19, 2002 at 12:55:20PM -0500, Jeff Garzik wrote:
> >There is *NO* module that does this right now and can be considered even
> >close to working.  The rule always has been "register yourself when you
> >are ready for use".  You're trying to add this new "You can fail after
> >registering yourself" semantic for brain dead coders that can't write an
> >init function to save thier ass.  My position is that in doing so, you
> >fuck all of us that do write a reasonable init sequence and handle our
> >error conditions.  Plus, since this is a changes in semantics, you have
> >possibly 50 or 100 modules that rely on the old behaviour, and maybe a 
> >few
> >that are broken in regards to registration ordering.  I think you are
> >trying to fix the wrong group of modules here.
> >
> >So, to me, the answer is clear.  The rule is hard and fast, you don't 
> >hand
> >out your function pointers to other modules or the core kernel until you
> >are ready for them to be used.  Don't muck with the module loader to 
> >solve
> >the problem, fix the maybe 4 or 5 modules that might violate this rule.
> 
> 
> 
> violently agreed.  This has the potential for requiring an update of 
> almost every driver in the kernel, does it not?

jeff, why not put some sample code in prominent public places
(kernel.org, or perhaps more appropriately kernelnewbies.org) that
provides examples of sane module code, since that appears to be
the problem here.

i ask you since i have a vague recollection of you mentioning
macro-fying all the nic drivers with m4 a while back, and to do this you
must have had some sort of basic skeleton to flesh out.

it won't help the idiots, but it may help people who are less than
intimate with the rules and regulations of lunix module authoring
(perhaps having come from a different OS).

j.

-- 
toyota power: http://indigoid.net/
