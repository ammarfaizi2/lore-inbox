Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288958AbSBXNxX>; Sun, 24 Feb 2002 08:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSBXNxN>; Sun, 24 Feb 2002 08:53:13 -0500
Received: from pm31-12.hobby.nl ([212.72.224.205]:31741 "EHLO vdpas.hobby.nl")
	by vger.kernel.org with ESMTP id <S288958AbSBXNwz>;
	Sun, 24 Feb 2002 08:52:55 -0500
Date: Sun, 24 Feb 2002 14:36:44 +0100
From: toon@vdpas.hobby.nl
To: linux-kernel@vger.kernel.org
Subject: Re: Some problems on a ThinkPad A30P (again...)
Message-ID: <20020224143644.A30013@vdpas.hobby.nl>
In-Reply-To: <200202241201.NAA11762@harpo.it.uu.se> <Pine.LNX.4.44.0202241314540.15470-100000@berenium.icemark.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202241314540.15470-100000@berenium.icemark.ch>; from beh@icemark.net on Sun, Feb 24, 2002 at 01:22:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 01:22:40PM +0100, Benedikt Heinen wrote:
> 
> > > -> Hibernation doesn't work at all (this used to work on the TP600
> > >    and on the TP A21P I had before)...
> 
> > What's the difference between suspend and hibernate?
> > Does the machine survive if you pull the power cord or enter the
> > BIOS setup screens?
> 
> I don't remeber, whether you could even enter the BIOS setup screen
> from hibernation, so I can't answer that...
> 
> In general - hibernation causes the notebook to dump the entire
> system memory contents and system status to a hibernation file
> (which is a contiguous hidden file on the Windows partition). Once
> the dump is done, the machine powers off completely - AC power cord
> and batteries can be safely removed/replaced during the time. When
> you switch the system back on, and the hibernation file contains
> system data, the RAM and system data is read back, and the system
> can resume, from where it is  (obviously just all active the
> network connections will be gone...  On the TP 600E, TP A21P this
> worked fine).
> The lack of hibernation is not a major problem for me though, as
> going to suspend and staying in suspend for 4-8 hours eats less
> battery than dumping 1 GB of RAM to disk and rereading it... Also,
> suspends for up to about 8 hours conserve battery even compared to
> rebooting; so most of the time I just suspend the machine for
> transport... I just hibernate or turn off the machine if it's going
> to be off for a longer period of time, or if I have to board a
> plane with it... ;)

You might want to try out the swsusp patch by Pavel Machek.
It is the beta (or even alpha) stage, but according to Pavels
latest comments it is starting to work quite well.

>From the patch:

+Software Suspend
+CONFIG_SOFTWARE_SUSPEND
+  Enable the possibilty of suspendig machine. It doesn't need APM.
+  You may suspend your machine by either pressing Sysrq-d or with
+  'swsusp' or 'shutdown -z <time>' (patch for sysvinit needed). It
+  creates an image which is saved in your active swaps. By the next
+  booting the kernel detects the saved image, restores the memory from
+  it and then it continues to run as before you've suspended.
+  If you don't want the previous state to continue use the 'noresume'
+  kernel option. However note that your partitions will be fsck'd and
+  you must re-mkswap your swap partitions/files.

Regards,
Toon.
-- 
 /"\                             |   Windows XP:
 \ /     ASCII RIBBON CAMPAIGN   |        "Sorry Dave...
  X        AGAINST HTML MAIL     |         I'm afraid I can't do that."
 / \
