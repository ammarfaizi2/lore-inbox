Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTKITxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbTKITxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:53:37 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:60290 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262790AbTKITxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:53:34 -0500
Date: Sun, 9 Nov 2003 19:50:00 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>, <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
Subject: Re: Some thoughts about stable kernel development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[Off-list]

Quote from Krzysztof Halasa <khc@pm.waw.pl>:
> Such a scenario is real and that way we might
> end up with official kernel being unusable for any Internet-connected
> tasks for weeks.

This does highlight a real issue - I am concerned by the number of
posts on sites like lwn.net saying things like, "Oh, I'm using 2.6 as
my standard kernel now", when it is clear that a lot of those users
simply do not understand the issues.  


> 
> Here is what I propose:
> As all of you know, the development cycle can be shortened by using
> two separate trees for a stable kernel line.
> 
> Say, we're now at 2.4.23-rc1 stage. This "rc" kernel would also be
> known as 2.4.24-pre1. The maintainer would apply "rc"-class fixes to
> both kernels, and other patches (which can't go to "rc" kernel) would
> be applied to 2.4.24-pre1 only.
> 
> After 2.4.23-rcX becomes final 2.4.23, the 2.4.24-preX would become
> 2.4.24-rc1 and would be a base for 2.4.25-pre1.
> 
> This way:
> - there would be no time when patches aren't accepted
> - the development cycle would be shorter. In fact it would be much
>   less important as there would always be an up-to-date stable version.
> - we would avoid a mess of having two separate trees, with different
>   fixes going in and out.
> - the amount of added maintainer's work is minimal, especially if patch
>   authors specify which tree they want it to go in (i.e. even a small
>   trivial patch would be applied to "pre" only if requested by the
>   author).
> - the 2.X.Y-pre* patch would always be based on latest 2.X.Y-1-rc or
>   final kernel.
> - as an option, we could go from absolute to incremental -pre and -rc
>   patches: i.e. rc2 would be based on rc1 and pre2 on pre1. It would be
>   easier for both disks and people (no need to patch -R).
> 
> Of course, I know 2.4-ac patches maintained by Alan Cox fulfilled
> some (most?) of these points, even if it wasn't their primary function.
> 
> This mail isn't about criticizing anyone nor anything, and is not only
> related to 2.4 kernel - I just try to make the development process of
> stable kernel lines a little better.
> 
> Comments?
> -- 
> Krzysztof Halasa, B*FH
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
