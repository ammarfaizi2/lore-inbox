Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbUKACq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbUKACq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 21:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKACq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 21:46:28 -0500
Received: from cantor.suse.de ([195.135.220.2]:60075 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261726AbUKACqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 21:46:21 -0500
Date: Mon, 1 Nov 2004 03:41:29 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, schwidefsky@de.ibm.com
Subject: Re: 2.6.10-rc1-mm2: konqueror crash because of cputime patches
Message-ID: <20041101024129.GB1694@wotan.suse.de>
References: <200410291823.34175.rjw@sisk.pl> <20041030155252.GA11515@wotan.suse.de> <200410301837.25828.rjw@sisk.pl> <200410311651.23631.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410311651.23631.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[intentional fullquote]

On Sun, Oct 31, 2004 at 04:51:23PM +0100, Rafael J. Wysocki wrote:
> > > Yes, on a Dual Opteron with web browsing.  Similar with firefox.
> > 
> > Can you, please, send me your .config?
> > 
> > There's something nasty going on here.
> > 
> > For konqueror vs 2.6.10-rc1-mm2, I have the problem reproduced on the dual 
> > Opteron machine, although the konqueror itself is different (3.3.1) than on 
> > the UP box (3.2.3): it (ie the konqueror) starts normally, but crashes when
> > try to open an arbitrary web page (eg linuxtoday.com).
> 
> Well, an arbitrary web page need not be sufficient.  Apparently, the web page 
> needs to contain JavaScript to make konqueror crash.  Also, when JavaScript 
> is disabled in konqueror, it works normally, so I assume that it crashes on 
> an attempt to execute JavaScript.
> 
> [-- snip]
> > I think I'll first try to play with the .config settings.  Then, I'll search 
> > through the patches.
> 
> Done.  Evidently, if the cputime patches:
> 
> cputime-introduce-cputime-fix.patch
> cputime-introduce-cputime.patch
> cputime-missing-pieces.patch
> 
> are reversed, konqueror works fine again on 2.6.10-rc1-mm2 (verified on two 
> different systems).
> 
> I have created a bugzilla entry for it at:
> http://bugzilla.kernel.org/show_bug.cgi?id=3675
> 
> If you need any more information, please let me know and I'll post it there.

Ok thanks. I will leave it to Martin to figure out. 

-Andi
