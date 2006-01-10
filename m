Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWAJE12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWAJE12 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 23:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWAJE12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 23:27:28 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:13829 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751237AbWAJE12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 23:27:28 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Tue, 10 Jan 2006 01:44:59 +0000
User-Agent: KMail/1.9
Cc: Bernd Petrovitsch <bernd@firmix.at>, Oliver Neukum <oliver@neukum.org>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <5t06S-7nB-15@gated-at.bofh.it> <1136824149.5785.75.camel@tara.firmix.at> <1136824880.9957.55.camel@mindpipe>
In-Reply-To: <1136824880.9957.55.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100145.00044.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 16:41, Lee Revell wrote:
> On Mon, 2006-01-09 at 17:29 +0100, Bernd Petrovitsch wrote:
> > On Mon, 2006-01-09 at 11:19 -0500, Lee Revell wrote:
> > > On Mon, 2006-01-09 at 17:14 +0100, Oliver Neukum wrote:
> > > > Am Montag, 9. Januar 2006 17:04 schrieb Lee Revell:
> > > > > On Mon, 2006-01-09 at 17:02 +0100, Oliver Neukum wrote:
> > > > > > Am Montag, 9. Januar 2006 16:15 schrieb Lee Revell:
> > > > > > > On Mon, 2006-01-09 at 15:28 +0100, Oliver Neukum wrote:
> > > > > > > > Am Montag, 9. Januar 2006 15:18 schrieb Robert Hancock:
> > > > > > > > > Yaroslav Rastrigin wrote:
> > > > > > > > > > Well, I could find more or less reasonable explanation of
> > > > > > > > > > this behaviour - different VM policies of two OSes and
> > > > > > > > > > strangely strong and persistent belief "Free RAM is a
> > > > > > > > > > wasted RAM" among kernel devs. Free RAM is not a wasted
> > > > > > > > > > RAM, its a memory waiting to be used ! Whenever it is
> > > > > > > > > > needed by apps I'm launching or working with.
> > > > > > > > >
> > > > > > > > > There is no different VM policy here, Windows behaves quite
> > > > > > > > > similarly. It does not leave memory around unused, it uses
> > > > > > > > > it for disk cache.
> > > > > > > >
> > > > > > > > That doesn't mean that the rate of eviction is the same.
> > > > > > > > Is it possible that read-ahead is not aggressive enough?
> > > > > > >
> > > > > > > Enough for what?  What is the exact problem you are trying to
> > > > > > > solve?
> > > > > >
> > > > > > Quicker application startup.
> > > > >
> > > > > Why do you look to the kernel first?  The obvious explanation is
> > > > > that Linux desktop apps are more bloated than their Windows
> > > > > counterparts.
> > > >
> > > > It is the most efficient place. An improvement to the kernel will
> > > > improve all starting times.
> > >
> > > I think you'll get at most a 10% or 20% speedup by improving the
> > > kernel, while some of these apps (think Nautilus vs Windows Explorer)
> > > will need to be 1000% faster to seem reasonable to a Windows user.
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

Sounds like a broken configuration to me. Of course the usual array of 
hardware specs, configuration, filesystem, free RAM, etc. all play into this, 
but no KDE application, including the originally cited Kate, takes longer 
than 1s to start on this machine (1.6GHz P-M, 2MB L2, 400MHz FSB, 1GB 
PC2700).

Hell kfm is probably a hell of a lot more bloated than Nautilus and it's 
pretty fast to start first time (1-2s), and cached it's pretty much 
instantaneous (I'd say less than 400ms). Fast enough, no?

Sounds like the kernel is plenty fast.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
