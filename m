Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVCCSHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVCCSHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVCCSFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:05:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:55496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262504AbVCCSEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:04:38 -0500
Date: Thu, 3 Mar 2005 10:02:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Adrian Bunk <bunk@stusta.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050303171226.GD11268@kroah.com>
Message-ID: <Pine.LNX.4.58.0503030955460.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net> <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com> <4226CA7E.4090905@pobox.com>
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org> <20050303170808.GG4608@stusta.de>
 <20050303171226.GD11268@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Greg KH wrote:
> 
> Then either the patch author splits out the bug if they want to, or we
> punt and say "wait for 2.6.12".  Distros can then decide if they want to
> take the whole $big_patch in their releases, if they are near a release
> cycle.

Yes. Exactly.

We're not aiming for "perfect". Just _trying_ to be perfect is what would
kill the whole scheme in the first place. We'd be aiming for "known
rules".

Whether people _agree_ with those rules is then actually not a huge issue. 
There will _always_ be things that people don't agree with. Aiming for 
consistency is worthwhile in itself.

(Of course, the rules _do_ matter in the sense that there has to be some 
point to the consistency. You can have a consistent rule that "the 
ChangeLog entries must rhyme", and I think it's a great rule, and I 
encourage anybody who wants to to set up such a "rhyming kernel tree", but 
that doesn't mean that it makes a lot of difference to people ;).

So havign strict rules that allow _one_ kind of consistency that people 
agree is good is a fine idea.

And Adrian, you can always have a different tree that has another set of 
rules - and if you use BK you can merge the two and have the "combination 
of the rules" tree. The reason I would _stronly_ urge very tight rules is 
that if they aren't tight, it ends up having all the problems we've always 
seen in other trees.

For example, if the "tight rules tree" allowed reverting an otheriwse good
patch because it had a bug (instead of trying to fix the bug), then I
would never be able to pull that tree into mine. It would take development
_backwards_, and thus it might be sensible for a vendor, but it would
automatically mean that it's not a good base for the next kernel version.

And if I can't just say "ok, I'll always take the 'tight rules' tree", 
then we'd get into the forward-and-backward porting hell again, which 
would make the whole tree totally pointless. See my point?

			Linus
