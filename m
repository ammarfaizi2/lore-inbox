Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVCKRpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVCKRpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCKRpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:45:09 -0500
Received: from THUNK.ORG ([69.25.196.29]:29904 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261237AbVCKRo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:44:57 -0500
Date: Fri, 11 Mar 2005 12:44:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Moritz Muehlenhoff <jmm@inutil.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>,
       Volker Braun <volker.braun@physik.hu-berlin.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Average power consumption in S3?
Message-ID: <20050311174433.GA6735@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Moritz Muehlenhoff <jmm@inutil.org>,
	Martin Josefsson <gandalf@wlug.westbo.se>,
	Volker Braun <volker.braun@physik.hu-berlin.de>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050309142612.GA6049@informatik.uni-bremen.de> <1110388970.1076.48.camel@tux.rsn.bth.se> <20050310180826.GA6795@informatik.uni-bremen.de> <20050311034615.GA314@thunk.org> <1110516679.32557.350.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110516679.32557.350.camel@gaston>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 03:51:19PM +1100, Benjamin Herrenschmidt wrote:
> I've sort-of been waiting for ATI to tell me how to retreive the proper
> memory register setting from the BIOS, since the code in there currently
> is quite powerbook specific, and might not write the exact correct value
> on all models. I suppose it works fine on yours so far, but I'd rather
> have a way to know the right value ... unfortunately, they didn't reply
> on this request.

There have been probably about 40 or 50 positive reports from people
on a wide variety of Thinkpad laptops (most generally recent models)
where it has worked.  There were two that didn't, but it wasn't clear
at least to me whether they were true incompatibilities or unrelated
problems caused by old BIOS levels, et. al.   

What I would suggest doing is changing the code to use a blacklist
instead of a whitelist, and make it optional with a CONFIG option that
is marked experimental, and then get it into the mainline for
additional testing.  If we can get ATI to give us the right way to do
it, great, but if they aren't being responsive, maybe we should just
do it empirically.

						- Ted
