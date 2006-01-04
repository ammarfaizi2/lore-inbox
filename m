Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965317AbWADWqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965317AbWADWqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbWADWqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:46:03 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:44142 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S965315AbWADWqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:46:01 -0500
Date: Wed, 04 Jan 2006 17:45:39 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 0/15] Ubuntu patch sync
In-reply-to: <20060104143023.5b2f7967@dxpl.pdx.osdl.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1136414740.4430.44.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003P992UCY@a34-mta01.direcway.com>
 <20060104140627.1e89c185@dxpl.pdx.osdl.net> <1136412768.4430.28.camel@grayson>
 <20060104143023.5b2f7967@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-04 at 14:30 -0800, Stephen Hemminger wrote:
> On Wed, 04 Jan 2006 17:12:48 -0500
> Ben Collins <ben.collins@ubuntu.com> wrote:
> 
> > On Wed, 2006-01-04 at 14:06 -0800, Stephen Hemminger wrote:
> > > On Wed, 04 Jan 2006 16:59:02 -0500
> > > Ben Collins <bcollins@ubuntu.com> wrote:
> > > 
> > > > These patches are just attempts to merge code from the ubuntu kernel tree.
> > > > This is most of the differences between our tree and stock code (not
> > > > necessarily all differences, since we do have a lot of external drivers
> > > > pulled in).
> > > 
> > > Why not submit them too?
> > 
> > Because neither I nor Ubuntu maintains them as upstream. I would rather
> > leave it to the upstream authors of those drivers (e.g. rt2400, rt2500,
> > unionfs, etc.) to submit their own code to Linus.
> > 
> 
> Just want to needle the upstream drivers to submit and get reviewed.

After dealing with literally dozens of upstream drivers, I think the
reasons boil down to a few categories:

1 - They know their code is crappy and they don't want to deal with code
review.

2 - They want to retain total control of their code. Having it in the
kernel tree means that the driver can be modified by others (in usually
correct ways) without their consent. They don't want to have to track
these changes and accommodate them. Also, external drivers tend to
retain a lot of backward compatibility for older kernel versions, that
would surely be dropped if it was placed in the kernel proper.

3 - They don't think their driver is important enough. They have a small
user base, and deal directly with those users.

4 - They just don't know how.

Not defending any of these reasons. I'd love to not have all this work
of pulling in and tracking the drivers that our users need/want, but
it's going to be a lot of work. Maybe I'll start emailing them about
getting their code in the kernel tree.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

