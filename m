Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWINQBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWINQBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWINQBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:01:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:48195 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750938AbWINQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:01:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k/EHPkyVkSUx4b0UfD9XpHh43oS+P12cxH37HSrRpVdCJHOHFz1YMuWwAy7Tl4vvBmBTnXLM1ubUkTa1fK9Ay1WCsTc5g/Eub0hzELiZVEcZS9PE7MsKIy3pbIiaVQ3KOBIXPj46mHrkPEcbQ+ZTaoAfcBzpFxzxrM5BO2dEIVQ=
Message-ID: <787b0d920609140901l46ce6cd3l400c33e74a67b8db@mail.gmail.com>
Date: Thu, 14 Sep 2006 12:01:48 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] i386/x86_64 signal handler arg fixes
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, hpa@zytor.com
In-Reply-To: <200609141540.44984.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com>
	 <200609141211.53087.ak@suse.de>
	 <787b0d920609140801r452ff7d7vdc2d96865836eefc@mail.gmail.com>
	 <200609141540.44984.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Andi Kleen <ak@suse.de> wrote:
>
> > I guess that should be deleted then?
>
> Yes. I will delete it right now. Thanks for the notice.

Er, OK. This means I can't patch it without conflict.
Mind just adding the six lines of code needed for
support of regparm(3) apps?

> > Currently you remap signals. Whatever you do this for
> > regparm(0) should also be done for regparm(3).
>
> Not sure I parse you here. You're asking how to fix the regparm(3)
> case?

No. I'd thought that the two cases should match.
The regparm(3) case should remap signals if and only if
the regparm(0) case remaps signals. Perhaps this
is not correct if the remapping is not needed for
native Linux apps; I doubt iBCS stuff would ever be
needing regparm(3) support.

Since you plan to delete the remapping cruft from
the regparm(0) case, then obviously it should not
be added to the regparm(3) case.
