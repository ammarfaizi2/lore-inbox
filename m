Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUJNVqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUJNVqy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUJNVqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:46:40 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:29659 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267928AbUJNVqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:46:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: swsusp: 8-order allocation failure on demand (was: Re: 2.6.9-rc2-mm1 swsusp bug report.)
Date: Thu, 14 Oct 2004 23:47:51 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       ncunningham@linuxmail.org, pascal.schmidt@email.de
References: <2HO0C-4xh-29@gated-at.bofh.it> <20041012085510.GC2292@elf.ucw.cz> <200410131929.11308.rjw@sisk.pl>
In-Reply-To: <200410131929.11308.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410142347.51241.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 of October 2004 19:29, Rafael J. Wysocki wrote:
> On Tuesday 12 of October 2004 10:55, Pavel Machek wrote:
> > Hi!
> > 
> > > > > Ok... And I guess it is nearly impossible to trigger this on demand,
> > > > > right?
> > > 
> > > I think it is possible.  Seemingly, on my box it's only a question of 
the 
> > > number of apps started.  I think I can work out a method to trigger it
> > > 90% of the time or so.  Please let me know if it's worthy of doing.
> > 
> > Yes, it would certainly help with testing...

Well, I can do that, it seems, 100% of the time.

The method is to do "init 5" (my default runlevel is 3, because vts become 
unreadable after I start X), log into KDE (as a non-root), start some X apps 
at random (eg. I run gkrellm, kmail, konqueror, Mozilla FireFox 32-bit w/ 
Flash plugin, and konsole with "su -") and run updatedb (as root, of course).

Apparently, running updatedb is essential.  After it finishes, on my box, you 
can forget of suspending to disk from under the X+KDE combo, even if the X 
apps (ie. kmail, konqueror, FireFox) are stopped before.  However, if 
updatedb is not run, the box usually suspends successfully.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
