Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbTHaXmb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 19:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTHaXma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 19:42:30 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:15497 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263065AbTHaXmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 19:42:19 -0400
Date: Mon, 1 Sep 2003 00:42:11 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Chris Frey <cdfrey@netdirect.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Andrea VM changes
Message-ID: <20030831234211.GB29239@mail.jlokier.co.uk>
References: <3F52199B.5020808@kegel.com> <20030831152246.A32685@netdirect.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831152246.A32685@netdirect.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Frey wrote:
> > The fact that incoming network traffic can be what causes the
> > OOM condition makes it Really Hard to decide which app deserves
> > the axe.
> 
> This may be a little off topic, but is there a way to manually select
> this?  I can see having a mode where everything stops thrashing
> for a while, in order to let the admin calmly kill off the offending
> process, as a useful feature.

I'd love to be able to select which app _doesn't_ deserve the axe.
I.e. not sshd, and then not httpd.

I once ran GCC on a box out there in netland, on a short bit of code,
and it was a surprise memory hog due to the usual GCC surprises.

It totally crippled the machine, for 18 hours until I was able to get
someone to reboot it.  No ssh, no http, no nothing except TCP initial
handshakes, and ping.  Not good.

When that happens I'd like the VM to notice that my most important
tasks (sshd and its subshells) aren't making progress and start
killing off other tasks.

The obvious answer is to turn off swap, but I like to have some swap
to hold static data that isn't much used, to free up some RAM.

-- Jamie
