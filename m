Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWF1Oh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWF1Oh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWF1Oh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:37:28 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:48396 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1030507AbWF1Oh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:37:26 -0400
Date: Wed, 28 Jun 2006 16:37:25 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Rahul Karnik <rahul@genebrew.com>
Cc: nigel@suspend2.net, Jens Axboe <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
Message-ID: <20060628143725.GC99263@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Rahul Karnik <rahul@genebrew.com>, nigel@suspend2.net,
	Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-kernel@vger.kernel.org
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271539.29540.nigel@suspend2.net> <20060627070505.GH22071@suse.de> <200606271739.13453.nigel@suspend2.net> <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29067a0606280428tff7b9dcp66bac3f2b83f4cc6@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 07:28:38AM -0400, Rahul Karnik wrote:
> This is something I don't understand. Why can you not submit patches
> that simply do things like "change method for writing image" and

Because the systematic answer of the suspend maintainer to that is
"you should write the image in userspace", to follow your example.


> reduce the difference between suspend2 and mainline? It may be more
> work, but I think you will find that incremental changes are a lot
> easier for people to review and merge.

Pavel wants everything in userspace.  Nigel wants everything but the
chrome in kernelspace.  Other kernels maintainers are split on the
issue, or don't care apart from "it should have been working for
years, damnit".  Andrew plainly said he doesn't know what's best, and
Linus seems to be very careful not to talk about it.

What should have happened is that suspend2 should have been merged
years ago, and then now transiting more of it to userspace or not
could be experimented, starting on a decently working base.  Pavel's
NIH-ing prevented that though.

In any case, don't use software suspend on a machine with data you
care about, and especially not uswsusp.  Side effect of userspace code
is that nobody from outside the project reviews it, and it's way too
young to have any kind of confidence in it.

  OG.

