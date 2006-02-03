Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWBCLJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWBCLJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWBCLJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:09:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44195 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932311AbWBCLJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:09:01 -0500
Date: Fri, 3 Feb 2006 12:08:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>, seife@suse.de
Cc: Lee Revell <rlrevell@joe-job.com>, nigel@suspend2.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203110842.GF2830@elf.ucw.cz>
References: <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org> <1138916079.15691.130.camel@mindpipe> <20060202142323.088a585c.akpm@osdl.org> <20060202142323.088a585c.akpm@osdl.org> <1138919381.15691.162.camel@mindpipe> <E1F4xZN-0001K1-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1F4xZN-0001K1-00@chiark.greenend.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 03-02-06 09:49:33, Matthew Garrett wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Follow up - do we have a rough idea how bad the suspend problem is, like
> > approximately what % of laptops don't DTRT and just suspend when you
> > close the lid?
> 
> It's arguable whether "just suspending when you close the lid" is
> actually DTRT, but if you want "how many x86 laptops can we
> successfully

:-).

> suspend and resume" then the number is between 80-90% for RAM and a
> little more than that for disk (numbers based on Ubuntu, other
> distributions don't have as much infrastructure for this right now).
> This is based on doing hacky things like unloading all the network and
> USB drivers before suspend, but by and large the driver situation is
> much improved. The single biggest problem is video reinitialisation, and
> that can't be solved in-kernel.

...and Ubuntu has vbetool solution which seems to work on 90% of all
notebooks, nice. Which big whitelist that basically says it all
works. Thanks for doing this work.

> (By and large, the biggest problem is repeated kernel regressions that
> hit suspend in bizarre ways. This doesn't get picked up on quickly
> because almost nobody is using this code, because "everyone knows" it
> doesn't work. Except it /does/. What we need is for distributions to
> actually work together on this, rather than everyone trying to fix the
> same problems independently, each coming up with different solutions and
> the world generally being a miserable place)

Perhaps we should force suspend/resume cycle at one of 10 boots :-).

Actually if you want to very quickly test if your changes did not
break swsusp, it should be enough to do 

swapoff -a; echo -n disk > /sys/power/state

. Your system will do half of system suspend, immediately followed by
resume.

								Pavel
-- 
Thanks, Sharp!
