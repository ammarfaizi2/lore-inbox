Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269430AbUIYWYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269430AbUIYWYd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 18:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269433AbUIYWYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 18:24:33 -0400
Received: from dp.samba.org ([66.70.73.150]:21185 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269430AbUIYWYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 18:24:12 -0400
Date: Sat, 25 Sep 2004 15:23:31 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925222331.GF580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1> <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org> <20040925195256.GB580@jeremy1> <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org> <20040925211055.GC580@jeremy1> <Pine.LNX.4.58.0409251445470.2317@ppc970.osdl.org> <20040925220843.GD580@jeremy1> <Pine.LNX.4.58.0409251513290.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251513290.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 03:18:50PM -0700, Linus Torvalds wrote:
> 
> Ok. Then we don't have to worry about somebody using a block count instead 
> of a byte count anywhere. That simplifies things a bit, at least.

Good. Glad to make your life easier sometimes :-).

> This will inevitably get the disk usage a _bit_ wrong if the file really 
> _does_ happen to use up an exact multiple of 1MB of disk, but hey, having 
> a heuristic that is sometimes a bit wrong is better than having one that 
> is always very wrong. 

Yep. My bug, sorry. Should be fixed from now on.

> This is totally untested, btw. For obvious reasons.

Ah, you just wait until we've finished making smb a tier 1
unix to unix filesystem. You'll be using it every day :-) :-).

Jeremy.
