Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVBSMzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVBSMzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 07:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVBSMzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 07:55:44 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:31185 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261706AbVBSMzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 07:55:38 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050217194217.GA2458@ucw.cz>
References: <20050211201013.GA6937@ucw.cz>
	 <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz>
	 <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz>
	 <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz>
	 <20050217194217.GA2458@ucw.cz>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 13:54:41 +0100
Message-Id: <1108817681.5774.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 17.02.2005, 20:42 +0100 schrieb Vojtech Pavlik:
> On Thu, Feb 17, 2005 at 04:04:55PM +0100, Vojtech Pavlik wrote:
> 
> > > drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489009]
> > > drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [78489009]
> > > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12) [78489014]
> > 
> > Ok, this is a regular 'I don't know what you mean' response from the
> > pad.
> > 
> > > drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489014]
> > > drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [78489014]
> > > drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12) [78489018]
> > 
> > But this return code is _very_ unusual. 0xfc means 'basic assurance test
> > failure' and should be reported only as a response to the 0xff command.
> 
> Kenan, can you check whether the 0xfc response is there even if you
> don't do the setres 7 command before this one?

Yes OK -- I will check. But as far as I know the 0xfe-answer from the
touchscreen means: "Please resend the last command". And 0xfc means:
"Error I didn't get that".

I also checked my original standalone-driver: Because of this behaviour
I always retried the last command 3 times if the responce from the
device was 0xfe or 0xfc.

