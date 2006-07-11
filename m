Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWGKWm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWGKWm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWGKWm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:42:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60301 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932221AbWGKWm6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:42:58 -0400
Date: Wed, 12 Jul 2006 00:42:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Cc: Fredrik Roubert <roubert@df.lth.se>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Message-ID: <20060711224225.GC1732@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org> <20060710094414.GD1640@igloo.df.lth.se> <Pine.LNX.4.64.0607102356460.17704@scrub.home> <20060711124105.GA2474@elf.ucw.cz> <Pine.LNX.4.64.0607120016490.12900@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607120016490.12900@scrub.home>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-07-12 00:21:31, Roman Zippel wrote:
> Hi,
> 
> On Tue, 11 Jul 2006, Pavel Machek wrote:
> 
> > > Apparently it changes existing well documented behaviour, which is a 
> > > really bad idea.
> > 
> > _well documented_? Where was it documented? Anyway, 2.6.17 behaviour
> > does not work on _many_ keyboards, like for example thinkpad x32...
> 
> Documentation/sysrq.txt and this was working on _many_ more keyboards just 
> fine.
> The fact is this patch changes existing behaviour, it either needs to be
> fixed or reverted. Adding new features is one thing, breaking existing 
> features is not acceptable without a very good reason.

Your "well documented" is sentence "you may have better luck
with"... okay, but we now have better sentence. Document it better.

BTW I believe that original way (alt down, sysrq down, b down) still
works before and after the patch.

Here's patch that updates docs with now-working trick.

Signed-off-by: Pavel Machek <pavel@suse.cz> 

diff --git a/Documentation/sysrq.txt b/Documentation/sysrq.txt
index e0188a2..58e04c0 100644
--- a/Documentation/sysrq.txt
+++ b/Documentation/sysrq.txt
@@ -43,7 +43,7 @@ On x86   - You press the key combo 'ALT-
            keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
            also known as the 'Print Screen' key. Also some keyboards cannot
 	   handle so many keys being pressed at the same time, so you might
-	   have better luck with "press Alt", "press SysRq", "release Alt",
+	   have better luck with "press Alt", "press SysRq", "release SysRq",
 	   "press <command key>", release everything.
 
 On SPARC - You press 'ALT-STOP-<command key>', I believe.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
