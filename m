Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTHBSGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 14:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTHBSGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 14:06:12 -0400
Received: from almesberger.net ([63.105.73.239]:12557 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S269967AbTHBSGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 14:06:11 -0400
Date: Sat, 2 Aug 2003 15:06:00 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030802150600.F5798@almesberger.net>
References: <20030802140444.E5798@almesberger.net> <3F2BF5C7.90400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2BF5C7.90400@us.ibm.com>; from niv@us.ibm.com on Sat, Aug 02, 2003 at 10:32:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nivedita Singhvi wrote:
> Also, most profiles of networking applications show the
> largest blip is essentially the user<->kernel transfer, and
> that would still remain the unaddressed bottleneck.

I have some hope that sendfile plus a NUMA-like approach will be
sufficient for keeping transfers away from buses and memory they
don't need to touch.

> The thing is, all the TOE efforts are propietary ones, to
> my limited knowledge.

Many companies default to "closed" designs if they're not given a
convincing reason for going "open". The approach I've described
may provide that reason.

There are also historicial reasons, e.g. if you want to interface
with the stack of Windows, or any proprietary Unix, you probably
need to obtain some of their source under NDA, and use some of
that information in your own drivers or firmware. Of course, none
of this is an issue here.

Since we're talking about 1-2 years of development time anyway,
legacy hardware (i.e. hardware choices influenced by information
obtained under an NDA) will be quite obsolete by then and doesn't
matter.

> Or is this not so needed?

Exactly. The "NUMA" approach would avoid the "common TOE design"
problem.

All you need is a reasonably well documented "general-purpose"
CPU (that doesn't mean it has to be an off-the-shelf design, but
most likely, the core would be an off-the-shelf one), plus some
NIC hardware. Now, if that NIC in turn has some hidden secrets,
this isn't an issue as long as one can still write a GPLed driver
for it.

Of course, there would be elements in such a system that vendors
would like to keep secret. But then, there always are, and so far,
we've found reasonable compromises most of the time, so I don't
see why this couldn't happen here, too.

Also, if "classical TOE" patches keep getting rejected, but an
open and maintainable approach makes it into the mainstream
kernel, also the business aspects should become fairly clear.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
