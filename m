Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUAPKlv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUAPKlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:41:51 -0500
Received: from gprs178-245.eurotel.cz ([160.218.178.245]:53376 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265305AbUAPKlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:41:50 -0500
Date: Fri, 16 Jan 2004 11:41:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: David Monro <davidm@amberdata.demon.co.uk>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org
Subject: Re: handling an oddball PS/2 keyboard (w/ patch)
Message-ID: <20040116104130.GA6431@ucw.cz>
References: <3FEA5044.5090106@amberdata.demon.co.uk> <20031225063936.GA15560@win.tue.nl> <200312251316.hBPDG7LT000163@81-2-122-30.bradfords.org.uk> <3FEAFDF3.80008@amberdata.demon.co.uk> <3FEB972B.4010406@amberdata.demon.co.uk> <20031226102210.GA11127@ucw.cz> <20031226235843.GA15973@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226235843.GA15973@win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 27, 2003 at 12:58:43AM +0100, Andries Brouwer wrote:

> On Fri, Dec 26, 2003 at 11:22:10AM +0100, Vojtech Pavlik wrote:
> 
> > This is intentional. Set 3 was never meant to be translated.
> 
> In fact it is just the opposite. Set 3 was designed to be translated.
> Look at the translated codes:
> Q (10), W (11), E (12), R (13), T (14), Y (15), U (16), I (17), O (18), P (19).
> Completely regular.
> Now look at the untranslated codes:
> Q (15), W (1d), E (24), R (2d), T (2c), Y (35), U (3c), I (43), O (44), P (4d).
> Messy.

Not at all. If you draw the whole keyboard, you can see the underlying
matrix of the Set3 codes.

And most importantly, there are more than a few set3 keyboards which have
scancodes which cannot be translated safely (either > 0x80 or codes like
0x7e).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
