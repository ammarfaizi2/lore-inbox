Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbUJaPul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbUJaPul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbUJaPul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:50:41 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:5554 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261211AbUJaPud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:50:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm2: konqueror crash because of cputime patches
Date: Sun, 31 Oct 2004 16:51:23 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200410291823.34175.rjw@sisk.pl> <20041030155252.GA11515@wotan.suse.de> <200410301837.25828.rjw@sisk.pl>
In-Reply-To: <200410301837.25828.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410311651.23631.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 of October 2004 18:37, Rafael J. Wysocki wrote:
> On Saturday 30 of October 2004 17:52, Andi Kleen wrote:
> > > Have you tested this on an SMP machine?  Mine is a UP.  I'll chek a dual 
> > 
> > Yes, on a Dual Opteron with web browsing.  Similar with firefox.
> 
> Can you, please, send me your .config?
> 
> There's something nasty going on here.
> 
> For konqueror vs 2.6.10-rc1-mm2, I have the problem reproduced on the dual 
> Opteron machine, although the konqueror itself is different (3.3.1) than on 
> the UP box (3.2.3): it (ie the konqueror) starts normally, but crashes when
> try to open an arbitrary web page (eg linuxtoday.com).

Well, an arbitrary web page need not be sufficient.  Apparently, the web page 
needs to contain JavaScript to make konqueror crash.  Also, when JavaScript 
is disabled in konqueror, it works normally, so I assume that it crashes on 
an attempt to execute JavaScript.

[-- snip]
> I think I'll first try to play with the .config settings.  Then, I'll search 
> through the patches.

Done.  Evidently, if the cputime patches:

cputime-introduce-cputime-fix.patch
cputime-introduce-cputime.patch
cputime-missing-pieces.patch

are reversed, konqueror works fine again on 2.6.10-rc1-mm2 (verified on two 
different systems).

I have created a bugzilla entry for it at:
http://bugzilla.kernel.org/show_bug.cgi?id=3675

If you need any more information, please let me know and I'll post it there.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
