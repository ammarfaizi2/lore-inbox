Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262047AbTCLVSI>; Wed, 12 Mar 2003 16:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262051AbTCLVSI>; Wed, 12 Mar 2003 16:18:08 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:16390 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S262047AbTCLVSG>;
	Wed, 12 Mar 2003 16:18:06 -0500
Date: Wed, 12 Mar 2003 22:28:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio too big device
Message-ID: <20030312212846.GA4925@win.tue.nl>
References: <20030312090943.GA3298@suse.de> <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org> <20030312101414.GB3950@suse.de> <20030312154440.GA4868@win.tue.nl> <b4nsh7$eg0$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4nsh7$eg0$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 05:59:03PM +0000, Linus Torvalds wrote:

> >We have seen *zero* drives that do not understand 256 sector commands.
> >Maybe such drives exist, but so far there is zero evidence.
> 
> That is definitely not true.  We definitely _have_ had drives that
> misconstrue the 256-sector case. It's been a long time, but they
> definitely exist.

I disagree. If you have any proof, please show it.

Let me repeat:
We have seen *zero* drives that do not understand 256 sector commands.

We have seen *one* drive (a six years old Maxtor 7850AV) that could not
sustain heavy load with max # secs set to 256, while it behaved better
with max set to 255.

But we have seen lots of old old drives that show all kinds of errors.

> The right limit for IDE is 255 sectors, and doing 256 sectors WILL fail
> on some setups.

Paul remarked: "So the 255 (or even the old 128) fixes things vs. 256,
but I'd feel better being 100% sure why. Is 255 a "fix" or a perturbation
that happens to paper over something else?"

I think there is no good reason to limit us to 255 sectors.

(And no reason for blacklists either - there is just no good evidence
that something is systematically wrong with 256 sectors for any brand or
model. Things would change if a second Maxtor 7850AV owner could confirm.)

Andries

