Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTFZWuq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 18:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264158AbTFZWsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 18:48:24 -0400
Received: from host151.spe.iit.edu ([198.37.27.151]:18114 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S264047AbTFZWpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 18:45:14 -0400
Date: Thu, 26 Jun 2003 17:59:27 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7[123] PS/2 issues (synaptics mouse and laptop keyboard)
Message-ID: <20030626225927.GA10965@lostlogicx.com>
References: <20030624164623.GL30282@lostlogicx.com> <20030626231532.D5633@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20030626231532.D5633@ucw.cz>
X-Operating-System: Linux found.lostlogicx.com 2.4.20-pfeifer-r1_pre7
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here are a couple of hopefully useful logs for the psmouse issues, I'll
get the keyboard issues as soon as I can get them to happen again :-\

--Brandon

On Thu, 06/26/03 at 23:15:32 +0200, Vojtech Pavlik wrote:
> On Tue, Jun 24, 2003 at 11:46:23AM -0500, Brandon Low wrote:
> > Afternoon kernel-gurus :)
> > 
> > Every 2.5 kernel since 2.5.70-mm9 that I have tried to use has failed to
> > work properly.  
> > The primary issue is as mentioned elsewhere that the synaptics touchpad
> > simply doesn't work when psmouse is loaded.  The psmouse_noext option
> > results in behaviour worse than the old default where no tap-to-click
> > works at all.  
> > 
> > However, there are other issues with the new ps/2 code, the keyboard
> > appears to get interrupt stormed at sometimes (or something) and I find
> > that letters either appear repeated (once for each keystroke after the
> > offending letter) or the keyboard response rate drops so low that I have
> > to type like a hunt-and-pecker in order to ensure that all of my
> > characters are captured.
> > 
> > I am up for any troubleshooting projects you wish to send me on, but I
> > don't know enough about kernel drivers to hunt down these issues in the
> > ps/2 code myself.
> 
> There is this nice and easy #define DEBUG in
> drivers/input/serio/i8042.c. Reproduce the problem and send me the
> relevant part of the log. I'll look into it.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="touch.log"

(interrupt, aux1, 12) [69925]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69926]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69926]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69926]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69926]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69927]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69927]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69927]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69927]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69928]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69928]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69928]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69928]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69929]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69929]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69929]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69929]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69930]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69930]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69930]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69930]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69931]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69931]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69931]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69931]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69932]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69932]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69932]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69932]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69933]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69933]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69933]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69933]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69934]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69934]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69934]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69934]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69935]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69935]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69935]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69935]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69936]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69936]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69936]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69936]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69937]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69937]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69937]
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [69937]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69938]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69938]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69938]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69938]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69939]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69939]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69939]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69939]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69940]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69940]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69940]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69940]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69941]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69941]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69941]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69941]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69942]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69942]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69942]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69942]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69943]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69943]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69943]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69943]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69944]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69944]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69944]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69944]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69945]
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [69945]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69945]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69945]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69946]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69946]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69946]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69946]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69947]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69947]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69947]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69947]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69948]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69948]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69948]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69948]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69949]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69949]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69949]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69949]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69950]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69950]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69950]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69950]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69951]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69951]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69951]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69951]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69952]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69952]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69952]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69952]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69953]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69953]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69953]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69953]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69954]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69954]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69954]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69954]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69955]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69955]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69955]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69955]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69956]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69956]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69956]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69956]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69957]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69957]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69957]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69957]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69958]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69958]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69958]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69958]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69959]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69959]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69959]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69959]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69960]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69960]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69960]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69960]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69961]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69961]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69961]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69961]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69962]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69962]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69962]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69962]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69963]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69963]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69963]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69963]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69964]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69964]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69964]
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [69964]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69965]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69965]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69965]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69965]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69966]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69966]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69966]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69966]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69967]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69967]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69967]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69967]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69968]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69968]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69968]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69968]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69969]
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [69969]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69969]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69969]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69970]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69970]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69970]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69970]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69971]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69971]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69971]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69971]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69972]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69972]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69972]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69972]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69973]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69973]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69973]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69973]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69974]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69974]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69974]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69974]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69975]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69975]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69975]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69975]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69976]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69976]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69976]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69976]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69977]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69977]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69977]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69977]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69978]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69978]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69978]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69978]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69979]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69979]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69979]
drivers/input/serio/i8042.c: b0 <- i8042 (interrupt, aux1, 12) [69979]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69980]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [69980]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [69980]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69980]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux1, 12) [69981]

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modprobe_psmouse.log"

Synaptics Touchpad, model: 1
 Firware: 4.1
 Sensor: 8
 new absolute packet format
input: Synaptics Synaptics TouchPad on isa0060/serio2
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62940]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [62940]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62941]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62941]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [62941]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62941]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62941]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [62941]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62941]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62941]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [62941]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62942]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62942]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [62942]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62942]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62942]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [62942]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62942]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62942]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [62942]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62942]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62942]
drivers/input/serio/i8042.c: ea -> i8042 (parameter) [62942]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62943]
drivers/input/serio/i8042.c: 91 -> i8042 (command) [62943]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [62943]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux1, 12) [62943]
drivers/input/serio/i8042.c: 92 -> i8042 (command) [62943]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [62943]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [62960]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [62960]
drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux3, 12, timeout) [62960]

--uAKRQypu60I7Lcqm--
