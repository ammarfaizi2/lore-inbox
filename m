Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVHIUgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVHIUgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 16:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVHIUgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 16:36:37 -0400
Received: from nef2.ens.fr ([129.199.96.40]:23051 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964944AbVHIUgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 16:36:37 -0400
Date: Tue, 9 Aug 2005 22:36:36 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: capabilities patch (v 0.1)
Message-ID: <20050809203636.GA28313@clipper.ens.fr>
References: <20050809052621.GA7970@clipper.ens.fr> <20050809053724.GG7991@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809053724.GG7991@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 22:36:36 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 05:37:56AM +0000, Chris Wright wrote:
> * David Madore (david.madore@ens.fr) wrote:
> > * Second, a much more extensive change, the patch introduces a third
> > set of capabilities for every process, the "bounding" set.  Normally
> 
> this is not a good idea.  don't add more sets.

Could you elaborate?  Why is adding sets bad?  From what I read of the
June 2000 discussions on the linux-privs-discuss mailing-list (<URL:
http://sourceforge.net/mailarchive/forum.php?forum_id=25120&max_rows=25&style=flat&viewmonth=200006
 >), a rather large consensus had formed around the idea that some
kind of bounding set was a useful idea (as a matter of fact, the
sendmail problem came essentially from the fact that some people
wanted an inheritable set and other people wanted a bounding set, and
the code was some mixture of the two); and it had been argued
convincincly that it could be made POSIX compliant if that is the
issue.  Plus, Solaris privileges also come in four sets.

If it's compatibility you're worried about, it seems to me that the
user interface can be made so that it will still work with the old
libcap and merely ignore the bounding set.  So full binary
compatibility will be achieved, at least on the user level.

Finally, if it's a matter of kernel policy, I seem to understand that
my patch has a snowball's chance in hell of ever being accepted in the
mainstream kernel (I mean, it's not as though this were new: patches
to make capabilities work have been available ever since the sendmail
exploit, and in five years they haven't ever been accepted, so I
suppose there's a reason to this), so adding a fourth set of
capabilities of my own initiative isn't going to change a thing there.

So what's the problem?

>						 if you really want to
> work on this i'll give you all the patches that have been done thus far,
> plus a set of tests that look at all the execve, ptrace, setuid type of
> corner cases.

Yes, I'm very interested in the test suite.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
