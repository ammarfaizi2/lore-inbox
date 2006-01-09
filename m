Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWAIQ3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWAIQ3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWAIQ3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:29:22 -0500
Received: from ns.firmix.at ([62.141.48.66]:58592 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S964863AbWAIQ3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:29:21 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Bernd Petrovitsch <bernd@firmix.at>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Oliver Neukum <oliver@neukum.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1136823598.9957.43.camel@mindpipe>
References: <5t06S-7nB-15@gated-at.bofh.it>
	 <200601091702.48955.oliver@neukum.org> <1136822646.9957.35.camel@mindpipe>
	 <200601091714.27303.oliver@neukum.org>  <1136823598.9957.43.camel@mindpipe>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 09 Jan 2006 17:29:09 +0100
Message-Id: <1136824149.5785.75.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 11:19 -0500, Lee Revell wrote:
> On Mon, 2006-01-09 at 17:14 +0100, Oliver Neukum wrote:
> > Am Montag, 9. Januar 2006 17:04 schrieb Lee Revell:
> > > On Mon, 2006-01-09 at 17:02 +0100, Oliver Neukum wrote:
> > > > Am Montag, 9. Januar 2006 16:15 schrieb Lee Revell:
> > > > > On Mon, 2006-01-09 at 15:28 +0100, Oliver Neukum wrote:
> > > > > > Am Montag, 9. Januar 2006 15:18 schrieb Robert Hancock:
> > > > > > > Yaroslav Rastrigin wrote:
> > > > > > > > Well, I could find more or less reasonable explanation of this behaviour - different VM policies of two OSes and 
> > > > > > > > strangely strong and persistent belief "Free RAM is a wasted RAM" among kernel devs. Free RAM is not a wasted RAM, its a memory waiting to be used ! 
> > > > > > > > Whenever it is needed by apps I'm launching or working with. 
> > > > > > > 
> > > > > > > There is no different VM policy here, Windows behaves quite similarly. 
> > > > > > > It does not leave memory around unused, it uses it for disk cache.
> > > > > > 
> > > > > > That doesn't mean that the rate of eviction is the same.
> > > > > > Is it possible that read-ahead is not aggressive enough?
> > > > > 
> > > > > Enough for what?  What is the exact problem you are trying to solve?
> > > > 
> > > > Quicker application startup.
> > > 
> > > Why do you look to the kernel first?  The obvious explanation is that
> > > Linux desktop apps are more bloated than their Windows counterparts.
> > 
> > It is the most efficient place. An improvement to the kernel will improve
> > all starting times.
> 
> I think you'll get at most a 10% or 20% speedup by improving the kernel,
> while some of these apps (think Nautilus vs Windows Explorer) will need
> to be 1000% faster to seem reasonable to a Windows user.

That's easy: Just start nautilus, OOorg, Firefox, a java-vm and
GNOME/KDE infrastructure at login time in the background (*eg* and
mlockall() the more important ones so that the are surely in RAM) and
"starting the app" is only a small program connecting to the respective
process to get a fork() there (e.g. like the "-remote" parameter in the
Mozilla family).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

