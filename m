Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbWIEDGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbWIEDGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 23:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965116AbWIEDGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 23:06:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1957 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965115AbWIEDG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 23:06:29 -0400
Date: Tue, 5 Sep 2006 13:05:57 +1000
From: Nathan Scott <nathans@sgi.com>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: akpm@osdl.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18-rc4-mm3 2/2] fs/xfs: Converting into generic boolean
Message-ID: <20060905130557.A3334712@wobbly.melbourne.sgi.com>
References: <44F833C9.1000208@student.ltu.se> <20060904150241.I3335706@wobbly.melbourne.sgi.com> <44FBFEE9.4010201@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <44FBFEE9.4010201@student.ltu.se>; from ricknu-0@student.ltu.se on Mon, Sep 04, 2006 at 12:24:41PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 12:24:41PM +0200, Richard Knutsson wrote:
> Nathan Scott wrote:
> >Hmm, so your bool is better than the next guys bool[ean[_t]]? :)
> Well yes, because it is not "mine". ;)
> It is, after all, just a typedef of the C99 _Bool-type.

Hmm, one is really no better than the other IMO.

> >I took the earlier patch and completed it, switching over to int
> >use in place of boolean_t in the few places it used - I'll merge
> >that at some point, when its had enough testing.
> >
> Is that set in stone? Or is there a chance to (in my opinion) improve 
> the readability, by setting the variables to their real type.

Nothings completely "set in stone" ... anyone can (and does) offer
their own opinion.  The opinion of people who a/ read and write XFS
code alot and b/ test their changes, is alot more interesting than
the opinion of those who don't, however.

In reality, from an XFS point of view, there are so few uses of the
local boolean_t and so little value from it, that it really is just
not worth getting involved in the pending bool code churn IMO (I see
72 definitions of TRUE and FALSE in a recent mainline tree, so you
have your work cut out for you...).

"int needflush;" is just as readable (some would argue moreso) as
"bool needflush;" and thats pretty much the level of use in XFS -
and we're using the "int" form in so many other places anyway...
but, I'll see what the rest of the XFS folks think and take it from
there.

cheers.

-- 
Nathan
