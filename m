Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVBCGmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVBCGmN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 01:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVBCGmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 01:42:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:1482 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262291AbVBCGiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 01:38:54 -0500
Subject: Re: [PATCH] radeonfb update (new patch)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050202222729.72ad31d4.akpm@osdl.org>
References: <1107411557.2189.24.camel@gaston>
	 <20050202222729.72ad31d4.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 17:38:10 +1100
Message-Id: <1107412690.2362.33.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-02 at 22:27 -0800, Andrew Morton wrote:

> I don't think Linus _can_ apply it - he doesn't have
> try_acquire_console_sem() for a start.

Right, that's a pre-req.

> I currently have:
> 
> add-try_acquire_console_sem.patch
> update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch
> radeonfb-massive-update-of-pm-code.patch
> radeonfb-build-fix.patch
> 
> And the patch which you've just send replaces
> radeonfb-massive-update-of-pm-code.patch.

Yes.

> Please confirm that all four are needed.
> 
> Are you seriously proposing this for 2.6.11??

Well... There should be no problem with
add-try_acquire_console_sem.patch and
update-aty128fb-sleep-wakeup-code-for-new-powermac-changes.patch.

radeonfb is another story, but the newer patch is definitely less
invasive. It really just fixes bugs and adds the bulk of PM stuff to
wakeup the newer chips, plus some backlight changes. It's been tested by
pmac users for a while, the only reason I sent it to you only recently
is that i was away for a month !

I'm hesitating about having it in 2.6.11 tho due to linus wanting to
release real soon, I'd rather have a bit more non-ppc testing just in
case though... but now it depends entirely on when linus plans to get
2.6.11 out of the door.

Ben.




