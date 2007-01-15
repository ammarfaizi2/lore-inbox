Return-Path: <linux-kernel-owner+w=401wt.eu-S1750973AbXAORd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbXAORd7 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 12:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXAORd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 12:33:59 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:59828 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbXAORd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 12:33:58 -0500
Date: Mon, 15 Jan 2007 18:32:16 +0100
From: Simon Budig <simon@budig.de>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19] USB HID: proper LED-mapping (support for SpaceNavigator)
Message-ID: <20070115173216.GA4582@budig.de>
References: <20070114231135.GA29966@budig.de> <Pine.LNX.4.64.0701150938180.16747@twin.jikos.cz> <20070115162541.GA3751@budig.de> <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701151743170.16747@twin.jikos.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina (jikos@jikos.cz) wrote:
> On Mon, 15 Jan 2007, Simon Budig wrote:
> > Yeah, it was easy to port over. Did the hid-debug stuff disappear
> > completely? What would I use instead?
> 
> No, it didn't disappear, it was just moved to include/linux/hid-debug.h. 
> Should I wait for an updated patch that uses hid-debug.h again?

Thanks, I missed that. Since these issues are unrelated I'll just submit
a trivial patch for the hid-debug.h stuff.

Is it possible that there is a regression in the hid-debug stuff? The
mapping does not seem to appear in the dmesg-output. I unfortunately
don't have an earlier kernel available right now to verify, but now the
output on plugging in the device looks like this:

[...]
usbcore: registered new interface driver hiddev
hid-debug: input GenericDesktop.X = 0
hid-debug: input GenericDesktop.Y = 0
hid-debug: input GenericDesktop.Z = 0
hid-debug: input GenericDesktop.Rx = 0
hid-debug: input GenericDesktop.Ry = 0
hid-debug: input GenericDesktop.Rz = 0
[...]

which looks bogus to me, IIRC earlier versions really printed the
mapping to linux input events at this point.

Anyway, the patch is correct anyway, will submit it soon.

Bye,
        Simon
-- 
              simon@budig.de              http://simon.budig.de/
