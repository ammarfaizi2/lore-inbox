Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWBTONA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWBTONA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWBTONA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:13:00 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28304 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964927AbWBTOM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:12:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Olivier Galibert <galibert@pobox.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 20 Feb 2006 15:13:23 +0100
User-Agent: KMail/1.9.1
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1140437152.3429.20.camel@mindpipe> <20060220123122.GA6086@dspnet.fr.eu.org>
In-Reply-To: <20060220123122.GA6086@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602201513.23849.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 20 February 2006 13:31, Olivier Galibert wrote:
> On Mon, Feb 20, 2006 at 07:05:52AM -0500, Lee Revell wrote:
> > My point was simply that "we need this now" is not a good argument for
> > immediate merging - I was not trying to imply that you aren't working
> > fast enough ;-)
> 
> What about "we need this two years ago" ?
> 
> I'm having a really hard time convincing myself that Pavel and
> friends, while rather good as developpers, haven't succumbed to a bad
> case of NIH syndrome.

Actually "Pavel and frieds" are Pavel and _me_ and _I_ don't like what
you're saying here.

> Even with wanting to move as many things to 
> userspace as possible, merging suspend2 with cleanups if necessary,
> _then_ starting from there to move things to userspace seems more
> realistic long-term.

The _only_ thing we moved to the user space was the writing and reading
of the image.  [We moved it quite literally, by porting the analogous swsusp
code from the current -mm.]

Currently we are _not_ moving _anything_ to the user space.  We're just
_implementing_ some things in the user space, but _not_ from scratch.

> Right now it really looks like they're only 
> trying to redo what's already in suspend2, tested and debugged, only
> different and new, hence untested and undebugged.

Actually a lot of the code that we use _has_ _been_ tested and debugged,
because it _is_ used on a daily basis by many people, like eg.:
- MD5 from the coreutils package,
- libLZF (the original one)
(openSSL wil be used soon for the image encryption).

And I'm not trying to redo suspend2 in the user space.  Instead I'm trying
to use the code that's _already_ _available_ in the user space to obtain
the functionality that suspend2 implements in the kernel space.

> The only thing I've seen that is really against suspend2 is the amount
> of code it adds to the kernel.  Given that said code is actively
> maintained, moving what can be moved to userspace can easily be done
> afterwards.

The problem is to merge suspend2 we'd have to clean it up first and
actually solve some problems that it works around.  That, arguably,
would be more work than just implementing some _easy_ stuff
in the user space.

Greetings,
Rafael
