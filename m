Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbTEXLDU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 07:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264244AbTEXLDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 07:03:20 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40463 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264243AbTEXLDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 07:03:18 -0400
Date: Sat, 24 May 2003 13:16:08 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-ID: <20030524111608.GA4599@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030523195757.GA27557@alpha.home.local> <20030524125252.58507d98.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030524125252.58507d98.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 12:52:52PM +0200, Stephan von Krawczynski wrote:
> On Fri, 23 May 2003 21:57:57 +0200
> Willy Tarreau <willy@w.ods.org> wrote:
> 
> > Hello !
> > 
> > On Fri, May 23, 2003 at 06:58:41AM -0600, Justin T. Gibbs wrote:
> > > > Ok. I managed to crash the tested machine after 14 days now. The crash
> > > > itself is exactly like former 2.4.21-X. It just freezes, no oops no
> > > > nothing. It looks like things got better, but not solved.
> > > 
> > > What is telling you that the freeze is SCSI related?  Are you running
> > > with the nmi watchdog and have a trace?  Do you have driver messages
> > > that you aren't sharing?
> > 
> > Stephen,
> > 
> > Justin is right, you should run it through the NMI watchdog, in the hope to
> > find something useful. If it hangs again in 14 days, you won't know why and
> > that may be frustrating. With the NMI watchdog, you at least have a chance to
> > see where it locks up, and you may find it to be within the driver, which
> > would help Justin stabilize it, or within any other kernel subsystem.
> > 
> > I had to use nmi_watchdog=2 at boot time, but other people use 1.
> > 
> > Regards,
> > Willy
> 
> Hello Willy,
> 
> I will do that, but I am not so confident about this, because the box runs X
> and a console oops output from nmi may as well not be visible nor written to
> disk.

OK, I understand. Other options are : serial console (worked for me after
several retries), remote syslogd (sometimes works if the system can still
schedule a bit), or patches such as netconsole, which sends the logs to a
remote host, and kmsgdump which tries to get them onto a floppy after a
panic or a forced dump.

Regards,
Willy

