Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSLHPP2>; Sun, 8 Dec 2002 10:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLHPP1>; Sun, 8 Dec 2002 10:15:27 -0500
Received: from h00207813f68b.ne.client2.attbi.com ([24.91.60.206]:13061 "EHLO
	buddha.badbelly.com") by vger.kernel.org with ESMTP
	id <S261238AbSLHPP1>; Sun, 8 Dec 2002 10:15:27 -0500
Subject: Re: Dazed and Confused
From: Gregory Boyce <gboyce@rakis.net>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1039348787.15058.6.camel@klendathu.telaviv.sgi.com>
References: <Pine.LNX.4.42.0212060948250.7121-100000@egg> 
	<1039348787.15058.6.camel@klendathu.telaviv.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 08 Dec 2002 10:22:38 -0500
Message-Id: <1039360959.1153.10.camel@lapdog.badbelly.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 06:59, Gilad Ben-Yossef wrote:
> On Fri, 2002-12-06 at 16:55, Greg Boyce wrote:
> 
> > I have an issue that I've been trying to track down for some time, and I
> > was hoping that someone might be able to provide me with a definitive
> > awnser.
> > 
> > I work in a company with a large number of Linux machine deployed all
> > around the country, and in some of the machines we've been seeing the
> > following error:
> > 
> > Uhhuh. NMI received. Dazed and confused, but trying to continue
> > You probably have a hardware problem with your RAM chips
> 
> I have had the exact same error happen a while back on a 2.2.x kernel.
> It did not seem to hurt anything but it made the QA dept. go bonkers so
> I've spent some time chasing it down and found out what caused it back
> then - perhaps the same, or similar, applies to your setup as well:
> 
> The machines in question were Intel ISP1100 1U servers and for various
> non important reasons I have built the kernel which they were running
> without APM support. Now these machines have 3 small non marked buttons
> on their front - one is the power button, one is the reset button and
> one was a suspend button. 
> 
> What I found out was that whenever anyone pressed the "suspend" button
> (usually because they meant to press the power or reset buttons and
> missed) the error in questions was logged. It seems that APM suspend is
> implemented (at least on those machines) as an NMI, and if you compiled
> the kernel sans APM support the NMI handling code simply did not grok
> that specific NMI and thus reported said error, which was otherwise
> harmless.

Most of these machines do have Intel motherboards.  I don't recall
seeing suspend buttons, but I'll take a look.  Thanks!

--
Greg

