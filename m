Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTIZIq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTIZIq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:46:27 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21388 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262009AbTIZIq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:46:26 -0400
Date: Fri, 26 Sep 2003 10:46:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Rob Landley <rob@landley.net>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030926084620.GA7877@ucw.cz>
References: <200309201633.22414.rob@landley.net> <200309221506.08331.rob@landley.net> <20030923000647.A1128@pclin040.win.tue.nl> <200309252027.57512.rob@landley.net> <20030926081542.GA21857@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926081542.GA21857@win.tue.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 10:15:42AM +0200, Andries Brouwer wrote:
> On Thu, Sep 25, 2003 at 08:27:57PM -0500, Rob Landley wrote:
> > Okay, a little fresh data:
> 
> > Sep 25 20:22:22 localhost kernel: atkbd.c: Unknown key (set 2, scancode 0xd1, 
> > on isa0060/serio0) pressed.
> > Sep 25 20:22:22 localhost kernel: i8042 history: d1 e0 51 e0 d1 e0 51 e0 d1 e0 
> > 51 e0 d1 e0 51 d1
> 
> e0 51 is PageDown press
> e0 d1 is PageDown release
> 
> You see here (apart from the first byte, which probably is the second half
> of a PageDown release): PageDown press, release, press, release, press, release,
> press, broken release.
> 
> A byte e0 was lost, and the release was not seen as a PageDown release.
> 
> > The page down key is the one that stuck.  I pressed another key (possibly 
> > either cursor up or page up) to unstick it, and then the next time I pressed 
> > page down it didn't register, but the time after that it did.
> 
> > You're talking about missed keypresses, but the end-user symptom I'm seeing
> > is definitely a missed key release
> 
> Yes - here a release was garbled.
> 
> Many people have reported missing key releases, and, as a consequence of that,
> stuck keys. Your reports feel a bit different: the e0 is sometimes lost from
> a key press, sometimes from a key release.

I'm wondering if it could be a bug in the i8042.c driver ...

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
