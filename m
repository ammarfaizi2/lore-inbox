Return-Path: <linux-kernel-owner+w=401wt.eu-S1751344AbWLNElF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWLNElF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 23:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWLNElF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 23:41:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:9536 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbWLNElD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 23:41:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UkipfTrWgM6LR6uvlE3qARsMaur7mMKr041sjZi0KIsSbccuq/6XeyJilSD0dOn2V/lVmjT8+PFRugukKpsjwmbWp677Qi9GDsYPaz6/bC3C+DfpAAYz5mG4rbGoxa3aI7pTLaxZQqDRFJHVV+71sWWD1KJh0r9qEMxwEOyixcg=
Message-ID: <72dbd3150612132041x15e6ab78u47c6ecf6826a3b23@mail.gmail.com>
Date: Wed, 13 Dec 2006 20:41:02 -0800
From: "David Rees" <drees76@gmail.com>
To: "Giacomo A. Catenazzi" <cate@cateee.net>
Subject: Re: Postgrey experiment at VGER
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <458025A5.2070001@cateee.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612131711.28292.a1426z@gawab.com> <458025A5.2070001@cateee.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Giacomo A. Catenazzi <cate@cateee.net> wrote:
> So a challange to the kernel hackers: build a mail filtering/proxy
> system, a' la BSD.
> I don't remember the specification and features, but IIRC the
> netfilter is not enough to do the graylisting (but pf was).
> Someone has some hints what kernel can do in the fight against
> spam?

I've gone through a number of anti-spam measures over the years. I
started with SpamAssassin, then bogofilter, greylisting, various RBLs
and most recently DSPAM.

SpamAssassin an bogofilter used to work pretty well, but over time
they let more and more spam through so I stopped using them.

Greylisting used to work very well, but recently more and more
spammers are retrying not to mention I kept on running across broken
mail servers that either wouldn't retry or would take forever to
retry. My users would also complain that email was broken when a
message would take hours to deliver instead of being delivered almost
immediately. They found it better to get spam than to occasionally
miss email or have to wait for email.

RBLs work pretty well as long as you choose the right ones that aren't
too aggressive with their lists. sbl-xbl.spamhaus.org is pretty
reliable and I have found it good at not blocking legitimate sources
of email.

DSPAM's learning ability seems to be very good (better than SA and
bogofilter) once trained and the web interface for training mail makes
it a snap to do (you can also do it via command line). It's also
flexible enough that it's easy to plug it into just about any mail
server configuration out there.

-Dave
