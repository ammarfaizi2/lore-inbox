Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCGNIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCGNIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVCGNIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:08:54 -0500
Received: from styx.suse.cz ([82.119.242.94]:53663 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261158AbVCGNI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:08:28 -0500
Date: Mon, 7 Mar 2005 14:11:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] fix NULL pointer deference in ALPS
Message-ID: <20050307131140.GA8065@ucw.cz>
References: <20050307122432.GG8138@ens-lyon.fr> <20050307131002.GA8025@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050307131002.GA8025@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 02:10:02PM +0100, Vojtech Pavlik wrote:

> On Mon, Mar 07, 2005 at 01:24:32PM +0100, Benoit Boissinot wrote:
> > I get a NULL pointer deference in with alps while suspending.
> > 
> > The following patch fixes it: alps_get_model returns a pointer or
> > NULL in case of errors, so we need to check for the results being NULL,
> > not negative.
> > 
> > Since it is trivial, it is maybe a candidate for 2.6.11.2.
> > 
> > It does not apply to -mm since the last occurence of alps_get_model
> > was corrected (but not the others), if needed i can send a patch for
> > -mm as well.
> 
> I already fixed it in my tree, but feel free to push it for the sucker
> tree.

Oops. No, 2.6.11 doesn't need that fix. Only -mm does, and it's already
queued.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
