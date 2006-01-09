Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWAIQxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWAIQxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWAIQxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:53:35 -0500
Received: from mail1.kontent.de ([81.88.34.36]:20193 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S964860AbWAIQxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:53:34 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Mon, 9 Jan 2006 17:53:35 +0100
User-Agent: KMail/1.8
Cc: Bernd Petrovitsch <bernd@firmix.at>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <5t06S-7nB-15@gated-at.bofh.it> <1136824149.5785.75.camel@tara.firmix.at> <1136824880.9957.55.camel@mindpipe>
In-Reply-To: <1136824880.9957.55.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091753.36485.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Januar 2006 17:41 schrieb Lee Revell:
> On Mon, 2006-01-09 at 17:29 +0100, Bernd Petrovitsch wrote:
> > On Mon, 2006-01-09 at 11:19 -0500, Lee Revell wrote:
> > > On Mon, 2006-01-09 at 17:14 +0100, Oliver Neukum wrote:
> > > > Am Montag, 9. Januar 2006 17:04 schrieb Lee Revell:
> > > > > On Mon, 2006-01-09 at 17:02 +0100, Oliver Neukum wrote:
> > > > > > Am Montag, 9. Januar 2006 16:15 schrieb Lee Revell:
> > > > > > > On Mon, 2006-01-09 at 15:28 +0100, Oliver Neukum wrote:
> > > > > > > > Am Montag, 9. Januar 2006 15:18 schrieb Robert Hancock:
> > > > > > > > > Yaroslav Rastrigin wrote:
> > > > > > > > > > Well, I could find more or less reasonable explanation of this behaviour - different VM policies of two OSes and 
> > > > > > > > > > strangely strong and persistent belief "Free RAM is a wasted RAM" among kernel devs. Free RAM is not a wasted RAM, its a memory waiting to be used ! 
> > > > > > > > > > Whenever it is needed by apps I'm launching or working with. 
> > > > > > > > > 
> > > > > > > > > There is no different VM policy here, Windows behaves quite similarly. 
> > > > > > > > > It does not leave memory around unused, it uses it for disk cache.
> > > > > > > > 
> > > > > > > > That doesn't mean that the rate of eviction is the same.
> > > > > > > > Is it possible that read-ahead is not aggressive enough?
> > > > > > > 
> > > > > > > Enough for what?  What is the exact problem you are trying to solve?
> > > > > > 
> > > > > > Quicker application startup.
> > > > > 
> > > > > Why do you look to the kernel first?  The obvious explanation is that
> > > > > Linux desktop apps are more bloated than their Windows counterparts.
> > > > 
> > > > It is the most efficient place. An improvement to the kernel will improve
> > > > all starting times.
> > > 
> > > I think you'll get at most a 10% or 20% speedup by improving the kernel,
> > > while some of these apps (think Nautilus vs Windows Explorer) will need
> > > to be 1000% faster to seem reasonable to a Windows user.
> > 
> > That's easy: Just start nautilus, OOorg, Firefox, a java-vm and
> > GNOME/KDE infrastructure at login time in the background (*eg* and
> > mlockall() the more important ones so that the are surely in RAM) and
> > "starting the app" is only a small program connecting to the respective
> > process to get a fork() there (e.g. like the "-remote" parameter in the
> > Mozilla family).
> 
> Have you tried this?  I suspect it still takes at least twice as long as
> on windows.
> 
> For example on my system there was already a "nautilus" process but
> "Places -> Home Folder" still took ~2 seconds to display anything, and
> ~8 seconds to completely render the window and icons.  On Windows this
> takes much less than a second.

Does the Windows Explorer draw icons based only on name and metadata?

	Regards
		Oliver
