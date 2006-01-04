Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWADXHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWADXHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWADXHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:07:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751622AbWADXHC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:07:02 -0500
Date: Wed, 4 Jan 2006 15:06:58 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/15] Ubuntu patch sync
Message-ID: <20060104150658.5b3f0d20@dxpl.pdx.osdl.net>
In-Reply-To: <1136414740.4430.44.camel@grayson>
References: <0ISL003P992UCY@a34-mta01.direcway.com>
	<20060104140627.1e89c185@dxpl.pdx.osdl.net>
	<1136412768.4430.28.camel@grayson>
	<20060104143023.5b2f7967@dxpl.pdx.osdl.net>
	<1136414740.4430.44.camel@grayson>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2006 17:45:39 -0500
Ben Collins <ben.collins@ubuntu.com> wrote:

> On Wed, 2006-01-04 at 14:30 -0800, Stephen Hemminger wrote:
> > On Wed, 04 Jan 2006 17:12:48 -0500
> > Ben Collins <ben.collins@ubuntu.com> wrote:
> > 
> > > On Wed, 2006-01-04 at 14:06 -0800, Stephen Hemminger wrote:
> > > > On Wed, 04 Jan 2006 16:59:02 -0500
> > > > Ben Collins <bcollins@ubuntu.com> wrote:
> > > > 
> > > > > These patches are just attempts to merge code from the ubuntu kernel tree.
> > > > > This is most of the differences between our tree and stock code (not
> > > > > necessarily all differences, since we do have a lot of external drivers
> > > > > pulled in).
> > > > 
> > > > Why not submit them too?
> > > 
> > > Because neither I nor Ubuntu maintains them as upstream. I would rather
> > > leave it to the upstream authors of those drivers (e.g. rt2400, rt2500,
> > > unionfs, etc.) to submit their own code to Linus.
> > > 
> > 
> > Just want to needle the upstream drivers to submit and get reviewed.
> 
> After dealing with literally dozens of upstream drivers, I think the
> reasons boil down to a few categories:
> 
> 1 - They know their code is crappy and they don't want to deal with code
> review.

Then find some friendly reviewers. It doesn't have to be a "throw crap
over the wall and see what flys back review". If it has dicey locking
and race issues, then the security and reliability of the whole system
is effected.

> 2 - They want to retain total control of their code. Having it in the
> kernel tree means that the driver can be modified by others (in usually
> correct ways) without their consent. They don't want to have to track
> these changes and accommodate them. Also, external drivers tend to
> retain a lot of backward compatibility for older kernel versions, that
> would surely be dropped if it was placed in the kernel proper.

And therefore their driver gets broken regularly. The modified by others
is almost always for small compatibility stuff.

> 3 - They don't think their driver is important enough. They have a small
> user base, and deal directly with those users.

If it is important enough for Ubuntu to ship, then it probably is important
enough to get out of the closet.

> 4 - They just don't know how.

Which is true, unfortunately, unless they read about it on a regular basis,
most people will plead ignorance.

> Not defending any of these reasons. I'd love to not have all this work
> of pulling in and tracking the drivers that our users need/want, but
> it's going to be a lot of work. Maybe I'll start emailing them about
> getting their code in the kernel tree.

I don't mean to play shoot the messenger, you are helping a lot by doing this
I wish every distro did.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
