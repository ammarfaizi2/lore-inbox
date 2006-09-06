Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWIFKGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWIFKGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 06:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWIFKGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 06:06:13 -0400
Received: from nef2.ens.fr ([129.199.96.40]:34834 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750752AbWIFKGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 06:06:12 -0400
Date: Wed, 6 Sep 2006 12:06:10 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060906100610.GA16395@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906002730.23586.qmail@web36609.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Wed, 06 Sep 2006 12:06:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 12:27:50AM +0000, Casey Schaufler wrote:
> --- David Madore <david.madore@ens.fr> wrote:
> > As we all know, capabilities under Linux are
> > currently crippled to the
> > point of being useless.
> 
> The current work in progress to support
> capability set on files will address this
> longstanding issue.

It seems to me that the issues of the capability inheritance semantics
and the capability filesystem support are quite orthogonal.  My patch
provides the first, and will quite happily live with a patch such as
<URL: http://lwn.net/Articles/142507/ > providing filesystem support.

Even in the absence of filesystem support, there is no reason for
capabilities not to be inheritable: this is what my patch addresses.
Of course, it is even more interesting in the presence of filesystem
support.  (I could provide a combined patch that would do both, with
xattrs, as a proof of concept.)

> Not a bad idea, but the notion of underprivileged
> processes has been tried before. The capability
> mechanism is explicitly designed to provide for
> the seperation and management of privilege and
> taking it in the "other" direction requires
> a rethinking of the inheritance mechanism.

Yes, it required a slight rethinking, and that is precisely what I am
providing: <URL: http://www.madore.org/~david/linux/newcaps/#semantics >.
Do you see anything specificly wrong with it?

> > In short: currently (i.e., prior to applying this
> > patch), Linux has
> > capabilities, but they are (deliberately) crippled,
> 
> The crippling is not deliberate.

At least the crippling of CAP_SETPCAP was deliberate and unnecessary:
it was done following an incorrect analysis by the sendmail team of a
caps-related sendmail exploit under Linux.

>				   It is
> unfortunate and represents a number of complex
> issues that are being resolved. Finally.

Resolving them is precisely what I proposed to do.  If you are saying
someone else also proposed to do the same, can you point to that work?
Perhaps we could merge usefully and thus go forward faster.

> Again, the capability scheme is intended to
> address the omnipotent userid problem. It pulls
> the userid and privilege apart. It also provides
> a more granular privilege. But it does not change
> what operations require privilege. That is left
> to wiser minds.

I don't quite understand what you're saying here.  Do you see
something wrong with my proposal for doing it?

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
