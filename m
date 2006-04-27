Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWD0Dli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWD0Dli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWD0Dli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:41:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932354AbWD0Dlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:41:37 -0400
Subject: Re: Simple header cleanups
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	 <1146105458.2885.37.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	 <1146107871.2885.60.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 04:41:34 +0100
Message-Id: <1146109295.2885.71.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 20:31 -0700, Linus Torvalds wrote:
> No. As mentioned, as long as the target audience is distributions and 
> library maintainers, I definitely think we should do help them as much as 
> possible. Our problems have historically been "random people" who have 
> /usr/include/linux being the symlink to "kernel source of the day", which 
> is an unsupportable situation. 

Right. I'm not interested in helping random people who want the kernel
source of the day; my point here is to just help the distributions get
their collective act together w.r.t. the kernel headers which we _have_
to ship in some form or other.

In particular, my reason for getting started on it was because for my
sins I own the glibc-kernheaders package in Fedora, and it's a complete
pain in my wossname.

We _do_ need to update periodically. I'd been doing it by cherry-picking
stuff like new ioctls and syscalls manually, and it was horrid. The
answer was obviously to have some way to at least partially automate the
process of updating from the real kernel... and it's fairly obvious how
we got from that requirement to the second of the git trees I'm showing
you now, having consulted the people who maintain equivalent packages in
other distributions along the way.

-- 
dwmw2

