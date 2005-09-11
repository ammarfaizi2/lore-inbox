Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVIKQMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVIKQMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVIKQMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 12:12:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750730AbVIKQMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 12:12:47 -0400
Date: Sun, 11 Sep 2005 09:12:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Osterlund <petero2@telia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What's up with the GIT archive on www.kernel.org?
In-Reply-To: <m3mzmjvbh7.fsf@telia.com>
Message-ID: <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Sep 2005, Peter Osterlund wrote:
>
> Since about 20 hours ago, it seems the
> linux/kernel/git/torvalds/linux-2.6.git/ archive on www.kernel.org
> alternates between at least two different HEAD commits.

Are there perhaps two different front-end machines? And mirroring
problems?

> Does anyone else see this? "host www.kernel.org" gives me two IP
> addresses:
> 
>         www.kernel.org is an alias for zeus-pub.kernel.org.
>         zeus-pub.kernel.org has address 204.152.191.5
>         zeus-pub.kernel.org has address 204.152.191.37
> 
> Is it possible that one of those computers hasn't received the latest
> changes for some reason?

Absolutely. The mirroring has been slow again lately. I've packed my 
archive, but I suspect others should much more aggressively now be using 
the "objects/info/alternates" information to point to my tree, so that 
they don't even need to have their objects at all (no packing 
even necessary - just running "git prune-packed" on peoples archives 
would get rid of any duplicate objects when I pack mine).

		Linus
