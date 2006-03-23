Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWCWDpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWCWDpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWCWDpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:45:47 -0500
Received: from main.gmane.org ([80.91.229.2]:34478 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965144AbWCWDpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:45:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Lifetime of flash memory
Date: Thu, 23 Mar 2006 12:46:44 +0900
Message-ID: <dvt5l0$413$1@sea.gmane.org>
References: <44203179.3090606@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060322)
In-Reply-To: <44203179.3090606@comcast.net>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> I have a kind of dumb question.  I keep hearing that "USB Flash Memory"
> or "Compact Flash Cards" and family have "a limited number of writes"
> and will eventually wear out.  Recommendations like "DO NOT PUT A SWAP
> FILE ON USB MEMORY" have come out of this.  In fact, quoting
> Documentation/laptop-mode.txt:
> 
>   * If you're worried about your data, you might want to consider using
>     a USB memory stick or something like that as a "working area". (Be
>     aware though that flash memory can only handle a limited number of
>     writes, and overuse may wear out your memory stick pretty quickly.
>     Do _not_ use journalling filesystems on flash memory sticks.)

I thought that journaling filesystems happen to overwrite exactly the same
place (where the journal is) many times... Am I mistaken?

So the effect is what we had for floppies (some many years ago) where sector
0 and others where FAT structure was kept were overused and start giving
errors - so the only solution was to throw away that floppy.

Hard disks had the same problem, but they have algorithms to relocate bad
clusters.

So do these "leveling algorithms" refer to the same? Relocating bad cells?
If not, you can see how a journaling system can fry a CF card quickly.

> 
> The question I have is, is this really significant?  I have heard quoted
> that flash memory typically handles something like 3x10^18 writes; and
> that compact flash cards, USB drives, SD cards, and family typically
> have integrated control chipsets that include wear-leveling algorithms
> (built-in flash like in an iPaq does not; hence jffs2).  Should we
> really care that in about 95 billion years the thing will wear out
> (assuming we write its entire capacity once a second)?
> 
> I call FUD.

3x10^18 is a bit overstating, IMHO. Don't have a reference now.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

