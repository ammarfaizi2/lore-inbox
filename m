Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267900AbUGaDsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267900AbUGaDsb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 23:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267903AbUGaDsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 23:48:31 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1231 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267900AbUGaDs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 23:48:29 -0400
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
From: Lee Revell <rlrevell@joe-job.com>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@bitplanet.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Olav Kongas <olav@enif.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <410B0486.6060706@bitplanet.net>
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee>
	 <20040728134313.GB4831@ucw.cz>  <410B0486.6060706@bitplanet.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1091245732.1677.56.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 30 Jul 2004 23:48:53 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-30 at 22:31, Kristian Høgsberg wrote:
> Vojtech Pavlik wrote:
> > On Wed, Jul 28, 2004 at 03:41:28PM +0300, Olav Kongas wrote:
> > 
> > 
> >>When trying to feed calibration information to a touchscreen driver with
> >>the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
> >>in 2.6.7. Only after the modification given in the patch below it was
> >>possible to use this ioctl command.
> >>
> >>Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses
> > 
> > 
> > It's a bug. I'll fix it.
> 
> On a related note - shouldn't there also be a EVIOCSLED, or am I missing 
> something obvious?  How do you set keyboard LEDs?
> 

Interesting you should mention keyboard LEDs.  Here is a patch that was
recently posted to replace the old, broken method of setting keyboard
lights (issue a command an busy-wait until you get an ACK) with an
improved one (using work queues and a semaphore).  It does not really
answer your question as such, but should be a good place to start.

http://lkml.org/lkml/2004/7/27/252

HTH,

Lee

