Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVGLQup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVGLQup (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVGLQup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:50:45 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:20622 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261611AbVGLQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:50:00 -0400
Subject: Re: Merging relayfs?
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Jason Baron <jbaron@redhat.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <17107.61864.621401.440354@tut.ibm.com>
References: <17107.6290.734560.231978@tut.ibm.com>
	 <Pine.LNX.4.61.0507121050390.25408@dhcp83-105.boston.redhat.com>
	 <1121183607.6917.47.camel@localhost.localdomain>
	 <17107.60140.948145.153144@tut.ibm.com>
	 <1121185393.6917.59.camel@localhost.localdomain>
	 <17107.61864.621401.440354@tut.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 12:49:41 -0400
Message-Id: <1121186981.6917.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 11:36 -0500, Tom Zanussi wrote:

>  > 
>  > I totally agree that the vmalloc way is faster, but I would also argue
>  > that the accounting to handle the separate pages would not even be
>  > noticeable with the time it takes to do the actual copying into the
>  > buffer.  So if the accounting adds 3ns on top of 500ns to complete, I
>  > don't think people will mind.
> 
> OK, it sounds like something to experiment with - I can play around
> with it, and later submit a patch to remove vmap if it works out.
> Does that sound like a good idea?

Sounds good to me, since different approaches to a problem are always
good, since it allows for comparing the plusses and minuses.  Not sure
if you want to take a crack using my ring buffers, but although they are
quite confusing, they have been fully tested, since I haven't changed
the ring buffer for a few years (although logdev itself has gone through
several changes).  I use the logdev device on a daily basis to debug
almost every kernel I ever touch.  When working with a new kernel, the
first thing I do is usually add my logdev patch.

Note to all:  The patch I posted is not the same patch that I usually
use (although the ring buffers _are_ the same), since I add stuff that
is usually more specific to what I do. So if something is broken with
it, I would greatly appreciate it if someone lets me know.

Thanks,

-- Steve


