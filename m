Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVBQTmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVBQTmD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 14:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVBQTmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 14:42:03 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:54504 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261178AbVBQTls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 14:41:48 -0500
Date: Thu, 17 Feb 2005 20:42:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050217194217.GA2458@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108457880.2843.5.camel@localhost> <20050215134308.GE7250@ucw.cz> <1108578892.2994.2.camel@localhost> <20050216213508.GD3001@ucw.cz> <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050217150455.GA1723@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2005 at 04:04:55PM +0100, Vojtech Pavlik wrote:

> > drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489009]
> > drivers/input/serio/i8042.c: 07 -> i8042 (parameter) [78489009]
> > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, aux, 12) [78489014]
> 
> Ok, this is a regular 'I don't know what you mean' response from the
> pad.
> 
> > drivers/input/serio/i8042.c: d4 -> i8042 (command) [78489014]
> > drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [78489014]
> > drivers/input/serio/i8042.c: fc <- i8042 (interrupt, aux, 12) [78489018]
> 
> But this return code is _very_ unusual. 0xfc means 'basic assurance test
> failure' and should be reported only as a response to the 0xff command.

Kenan, can you check whether the 0xfc response is there even if you
don't do the setres 7 command before this one?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
