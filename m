Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDAVn2>; Sun, 1 Apr 2001 17:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132570AbRDAVnR>; Sun, 1 Apr 2001 17:43:17 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:48391 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S132568AbRDAVnE>;
	Sun, 1 Apr 2001 17:43:04 -0400
Date: Sun, 1 Apr 2001 23:41:56 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
   Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Recent problems with APM and XFree86-4.0.1
Message-ID: <20010401234156.B15813@pcep-jamie.cern.ch>
In-Reply-To: <20010331021514.A6784@pcep-jamie.cern.ch> <200103310537.f2V5bDO06729@pcug.org.au> <20010331162513.C7946@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010331162513.C7946@pcep-jamie.cern.ch>; from lk@tantalophile.demon.co.uk on Sat, Mar 31, 2001 at 04:25:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> > > On that theme of power management with X problems, I have been having
> > > trouble with my laptop crashing when the lid is closed, instead of
> > > suspending as it used to.  The laptop is a Toshiba Satellite 4070CDT.
> > 
> > Can you please try adding
> > 	Option	"NoPM"
> > to the device section of XF86Config or (XF86Config) and then try suspending
> > and resuming.
> > 
> > This made suspend/resume much more reliable on the Thinkpad 600E with
> > XFree86 4.  Also you could try XFree86 4.0.2, as I know that it actually
> > does interact with APM (4.0.1 may have as well - I am not sure).
> 
> I'll try Option "NoPM", and XFree86 4.0.2 if I can find a conveniently
> RH7 compatible RPM.

I tried Option "NoRPM" with XFree86 4.0.1 and it seems to have fixed the
problem!  Yay!  Closing lid: suspend happens after a few beeps.  Open
lid, computer resumes and is working normally.  I guess the new code in
XFree86 was problematic.  Perhaps it's fixed in 4.0.2, but I haven't
tried that.

I've noticed other changes in suspend/resume.  I'm running Gnome now,
and it insists on running xscreensaver whenever I close the lid.
Somehow it is noticing the APM event, because this is very consistent.
Does anyone know how to disable this?  The setting "No screensaver"
under the list of screensavers didn't help -- it just runs a blank
screensaver which is even more confusing, because the computer appears
not to have resumed (when it's just a black screensaver).

cheers,
-- Jamie



> 
> I should point out that I've been using _some_ version of XFree86 4
> since before version 4.0 was released.  (XFree86 3 doesn't support this
> laptop's video adapter).  Suspend/resume worked fine and reliably until
> recently.
> 
> Another problem is that occasionally when X starts now, it will freeze
> the system.  So I suspect a bug was introduced in XFree86 4.0.1.
> 
> -- Jamie
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
