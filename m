Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270961AbTGPRIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 13:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270966AbTGPRHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 13:07:23 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:20882 "EHLO
	genius.impure.org.uk") by vger.kernel.org with ESMTP
	id S270961AbTGPRGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 13:06:08 -0400
Date: Wed, 16 Jul 2003 18:20:20 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: vojtech@suse.cz, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716172020.GC21896@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jens Axboe <axboe@suse.de>, vojtech@suse.cz,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <20030716170911.GB21896@suse.de> <20030716171323.GL833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716171323.GL833@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:13:23PM +0200, Jens Axboe wrote:

 > > Ah right, I thought cdparanoia was still ripper de jour..
 > > What's recommended these days?
 > 
 > It is, unfortunately it uses read/write on /dev/sg* directly so cannot
 > be used with "new path" that is so much faster. It's been a while since
 > I looked, I can check for a good cdda ripper that uses SG_IO tomorrow if
 > you don't find one first.

Ok. I'll add a note about this to post-halloween-2.5 sometime too
when www.codemonkey.org.uk reappears again.
[sidenote: please folks, no more mails telling me about this site going away,
 it'll be back real soon, it just had to be 'upgraded' to a raq2, which didn't
 go quite as smoothly as planned.].

 > I'm about to cave in and add block emulation of that part, too. It's a
 > bit more code, though.

If it'll make apps like cdparanoia take the fast path without needing
rewriting, then that sounds like a good idea, if only to stop the
'dancing mouse' problem, though this does seem to be running away
from a bug rather than fixing it. The real question is why are the
two interacting with each other like this..

		Dave

