Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVBSNQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVBSNQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 08:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVBSNQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 08:16:57 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:50052 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261595AbVBSNQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 08:16:55 -0500
Date: Sat, 19 Feb 2005 14:16:39 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050219131639.GA4922@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz> <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz> <20050217194217.GA2458@ucw.cz> <1108817681.5774.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108817681.5774.44.camel@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 01:54:41PM +0100, Kenan Esau wrote:

> > > But this return code is _very_ unusual. 0xfc means 'basic assurance test
> > > failure' and should be reported only as a response to the 0xff command.
> > 
> > Kenan, can you check whether the 0xfc response is there even if you
> > don't do the setres 7 command before this one?
> 
> Yes OK -- I will check. But as far as I know the 0xfe-answer from the
> touchscreen means: "Please resend the last command".

In theory, it should mean that even with the PS/2 spec. But it only
works so in the other direction - when the PC doesn't get the bytes
right.

The devices use this error code for any problem, and this of course
would lead to infinite loops if the system did always resend.

> And 0xfc means:
> "Error I didn't get that".

Why wouldn't it?

> I also checked my original standalone-driver: Because of this behaviour
> I always retried the last command 3 times if the responce from the
> device was 0xfe or 0xfc.

And did it actually help? Did the touchscreen ever respond with a 0xfa
"ACK, OK" response to these commands?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
