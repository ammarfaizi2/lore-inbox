Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270630AbTHCVG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 17:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271233AbTHCVG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 17:06:26 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:47001 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270630AbTHCVEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 17:04:33 -0400
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Roland McGrath <roland@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <8765lfxl21.fsf@deneb.enyo.de>
References: <200308021908.h72J82x10422@magilla.sf.frob.com>
	 <1059857483.20306.6.camel@dhcp22.swansea.linux.org.uk>
	 <8765lfxl21.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059944423.31901.8.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Aug 2003 22:00:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-08-03 at 08:22, Florian Weimer wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > #1 Lots of non posix afflicted intelligent programmers use the per
> > thread uid stuff in daemons. Its really really useful
> 
> It doesn't work reliably because the threading implementation might
> have to send signals which the current combination of credentials does
> not allow.

It works beautifully.  Its very effective for clone() using applications


> IMHO, POSIX is wrong to favor process attributes so strongly.  It
> wouldn't be a problem if there were other ways to pass these implicit
> parameters (such as thread-specific attributes, or, even better,
> syscall arguments).  But often there isn't.

The restriction in this case comes from a more fundamental thing - posix pthreads
is full of compromises so it can be done in user space. Clearly you can't split
uid's in user space very sanely.


