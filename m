Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUACW2A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbUACW2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:28:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:27300 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264288AbUACW16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:27:58 -0500
Date: Sat, 3 Jan 2004 14:27:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040103141029.B3393@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401031423180.2162@home.osdl.org>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <20040101001549.GA17401@win.tue.nl>
 <1072917113.11003.34.camel@fur> <200401010634.28559.rob@landley.net>
 <1072970573.3975.3.camel@fur> <20040101164831.A2431@pclin040.win.tue.nl>
 <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org>
 <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org>
 <20040103141029.B3393@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jan 2004, Andries Brouwer wrote:
> 
> Sure. It is not "need". It is "quality of implementation".
> Consider NFS.

The problems occur when there are things we _cannot_ guarantee, and that
user space starts unnecessarily to depend on. And that ends up resulting
in bugs waiting to happen. Bugs that many "normal" developers may never 
hit, simply because the quality of implementation ends up being so good 
that it hides the problem cases in regular usage.

And then a high-quality implementation actually ends up being 
_detrimental_. It's hiding problems that can still happen, they just 
happen rarely enough that the bugs don't get found and fixed.

And then the painful thing of forcing "stupid", aka "bad QoI" behaviour, 
actually ends up being the better thing in the long run.

			Linus
