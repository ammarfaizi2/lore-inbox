Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVGJTRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVGJTRI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVGJTQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:16:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:38866 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261179AbVGJTPk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:15:40 -0400
Date: Sun, 10 Jul 2005 21:16:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Roman Zippel <zippel@linux-m68k.org>, Bryan Henderson <hbryan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
Message-ID: <20050710191607.GA4102@ucw.cz>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com> <courier.42CEC422.00001C6C@courier.cs.helsinki.fi> <Pine.LNX.4.61.0507082108530.3728@scrub.home> <1120851221.9655.17.camel@localhost> <Pine.LNX.4.61.0507082154090.3728@scrub.home> <1121019702.20821.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121019702.20821.17.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 09:21:42PM +0300, Pekka Enberg wrote:

> Hmm. So we disagree on that issue as well. I think the point of review
> is to improve code and help others conform with the existing coding
> style which is why I find it strange that you're suggesting me to limit
> my comments to a subset you agree with.
> 
> Would you please be so kind to define your criteria for things that
> "need fixing" so we could see if can reach some sort of an agreement on
> this. My list is roughly as follows:
> 
>   - Erroneous use of kernel API
>   - Bad coding style
>   - Layering violations
>   - Duplicate code
>   - Hard to read code
 
The reason people post their patches for review is to get good feedback
on them. The problems you list above are mostly nitpicks. They must be
fixed before inclusion of the patch, but only make sense to start fixing
once the patch does a reasonable change.

Often patches have deeper problems (like "this won't ever work", "there
is a nice race hidden in there", "why do we need this part at all"), and
spotting those is much more valuable for both the sumbitter and the
progress of development.

Obviously, it's much harder to do that than to comment on a misplaced
brace.

It's an utter waste of effort to force a first time patch author to fix
all the style issues in his patch, just to see it rejected by the
maintainer because it is fundamentally wrong later.

Just something to consider.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
