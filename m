Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVBYNs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVBYNs6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 08:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVBYNs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 08:48:57 -0500
Received: from thunk.org ([69.25.196.29]:51138 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262697AbVBYNsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 08:48:42 -0500
Date: Fri, 25 Feb 2005 08:48:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: "'Greg Folkert'" <greg@gregfolkert.net>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Greg's Decree! (was Re: Linus' decrees?)
Message-ID: <20050225134824.GA5977@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Stuart MacDonald <stuartm@connecttech.com>,
	'Greg Folkert' <greg@gregfolkert.net>,
	'LKML' <linux-kernel@vger.kernel.org>
References: <1109280654.14960.5.camel@king.gregfolkert.net> <002201c51abd$712cf500$294b82ce@stuartm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002201c51abd$712cf500$294b82ce@stuartm>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 05:08:33PM -0500, Stuart MacDonald wrote:
> The post I reference mentions that Linus once said that a standard
> method to locate the source for a particular kernel would be to have
> it at /lib/modules/`uname -r`/build. This seems to be a symlink for
> vanilla kernels, and actual source for the FC3 installed kernels I
> have handy.
>
> I guess what I'm looking for is a collection of linux kernel policies.
> Is there such a collection?

Well, the place where Linus's policy surrounding 
/lib/modules/`uname -r`/build can be found in:

	/usr/src/linux/Makefile

The distributions (by and large) honor it, but other than that, you
seem to have a slightly overinflated view how much weight and how much
formalities such statements actually have.

The problem with collecting it, as other people have pointd out, is
that it implies that all such statements are valid forever (such as a
Pope's encyclical) or that we have some formal way of blessing a
statement by sprinkling Holy Penguin Pee on it, or some way of
retracting such a blessing (probably involving some ceremony involving
turning a candle upside down and snuffing it out :-).   

If the goal is to collect some hints about of out-of-kernel modules
and device drivers, there are places where that could be done, and I'd
probably suggest writing or updating a linux HOWTO as a part of the
Linux Documentation Project.  However, with the way in-kernel
interfaces are changing, one of things you will no doubt find as you
start collecting such hints is that the first hint is: "Get that
device driver or module into the mainline kernel sources; otherwise
your life will be nasty and brutish, and while perhaps not short, you
may soon wish it to be.  :-)"

						- Ted
