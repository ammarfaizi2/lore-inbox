Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266207AbUAIF3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 00:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUAIF3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 00:29:37 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:11183 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266207AbUAIF3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 00:29:36 -0500
Subject: Re: PATCH: Fix support for wide consoles in vt.c and
	include/linux/selection.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@users.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073621988.2003.40.camel@laptop-linux>
References: <1073621988.2003.40.camel@laptop-linux>
Content-Type: text/plain
Message-Id: <1073626143.828.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 09 Jan 2004 16:29:03 +1100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-09 at 15:19, Nigel Cunningham wrote:
> Hi.
> 
> In implementing a 'nice' display for Software Suspend, some users with
> wide VTs reported problems with distortion. These changes from signed to
> unsigned int/char fixed the issue and have been tested for around a year
> (guesstimate).
> 
> The only other user of getconsxy is vc_screen.c. It might benefit from
> matching changes, although the users who reported the problem to me said
> nothing about other issues with their displays, so far as I recall.
> 
> To actually use the functions from Suspend, the functions also had to be
> made non-static. Of course I could make this into 2 patches if desired.

Also make sure you grab the console semaphore when doing those things,
or recent 2.6's (at least -mm) will probably bark on you :)

Ben.

