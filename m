Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVHDVB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVHDVB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbVHDU70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:59:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13775 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262691AbVHDU56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:57:58 -0400
Date: Thu, 4 Aug 2005 22:56:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Message-ID: <20050804205609.GA1780@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston> <20050801203728.2012f058.Ballarin.Marc@gmx.de> <1122926885.30257.4.camel@gaston> <20050802095401.GB1442@elf.ucw.cz> <1123069255.30257.27.camel@gaston> <D6591B2F-4E98-48A0-A3DD-71AAC564278E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D6591B2F-4E98-48A0-A3DD-71AAC564278E@mac.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I'd like to get rid of shutdown callback. Having two copies of code
> >>(one in callback, one in suspend) is ugly.
> >
> >Well, it's obviously not a good time for this. First, suspend and
> >shutdown don't necessarily do the same thing, then it just doesn't  
> >work
> >in practice. So either do it right completely or not at all, but  
> >2.6.13
> >isn't the place for an half-assed hack that looks like a solution to
> >you.
> 
> One possible way to proceed might be to add a new callback that takes a
> pm_message_t: powerdown()  If it exists, it would be called in both the
> suspend and shutdown paths, before the suspend() and shutdown() calls to
> that driver are made.  As drivers are fixed to clean up and combine

No; please don't make driver model more complex than it already is.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
