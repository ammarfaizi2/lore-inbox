Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVBCXhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVBCXhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVBCXhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:37:34 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:54233 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262595AbVBCXhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:37:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Date: Fri, 4 Feb 2005 00:37:45 +0100
User-Agent: KMail/1.7.1
Cc: Dominik Brodowski <linux@dominikbrodowski.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
References: <200502021428.12134.rjw@sisk.pl> <200502032246.13057.rjw@sisk.pl> <20050203220051.GA1098@elf.ucw.cz>
In-Reply-To: <20050203220051.GA1098@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502040037.46251.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 3 of February 2005 23:00, Pavel Machek wrote:
> Hi!
> 
> > > You may not run k8 notebook on max frequency on battery. Your system
> > > will crash; and you might even damage battery.
> > 
> > When I don't compile in cpufreq, it seems to run at 1,8 GHz (the max)
> > all the time, on AC power as well as on battery.  Along with what you're
> > saying it leads to the conclusion that in fact I have to compile in cpufreq
> > or I can damage the battery otherwise.  Is that right?
> 
> Yes.
> 
> [It is strange, k8 notebooks are supposed to boot at 800MHz. Older
> arima prototype got it wrong and in 50% crashed during boot on battery
> power. OTOH if your machine is stable at battery at 1.8GHz... well
> then we'll have to search for other problem in cpufreq&resume....]

It seems to be stable, although I must admit I haven't run it on battery power
for longer than 5 min. without cpufreq and now I'm a bit reluctant to try. ;-)

Anyway the failing case seems to be when the frequency during suspend
is higher than during resume (eg when the image is created at 1800 MHz and the
CPU is running at 800 MHz right after restoring the image).
 
Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
