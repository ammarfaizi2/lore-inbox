Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932939AbWAEI2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932939AbWAEI2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbWAEI2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:28:36 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:25352 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932939AbWAEI2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:28:36 -0500
Date: Thu, 5 Jan 2006 09:28:25 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20060105092825.7153f8a8.khali@linux-fr.org>
In-Reply-To: <200601050515.07205.zippel@linux-m68k.org>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	<1135949941.25274.1.camel@localhost>
	<20051231193956.4271e2f0.khali@linux-fr.org>
	<200601050515.07205.zippel@linux-m68k.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

> On Saturday 31 December 2005 19:39, Jean Delvare wrote:
> 
> > So I believe that "choice" is an interesting Kconfig feature when used
> > with boolean options, but with modules I am not convinced, especially
> > when these modules have different dependencies.
> 
> Well, I'm always open to suggestions (or even better patches) to improve 
> tristate choices. Such interdependent options have to be done via a choice 
> group, so they are correctly handled by kconfig, otherwise you have 
> to live with the current compromise. OTOH how they are mapped to the user 
> interface is easily changeable.

What I like with the current "compromise" in the SAA1734 case is that,
if the user has only OSS or only ALSA enabled in the sound menu, then
he/she only sees one available module for SAA7134 sound support. It
keeps the configuration interface as simple as it can be. While when
using a choice, the user will still be presented a pre-item/menu, with a
single choice in there. This is what I think is confusing.

If "choice" could fall back to a simple option when the dependencies
are such that only once choice is actually possible, I think it would
improve the situation, in the case of the SAA7134. But I lack time to
propose an actual patch implementing this, and I also did not
investigate to see what it would do for the other use cases of "choice"
in the current kernel tree. Lastly I guess that some people may find it
even more confusing if things were done the way I suggest - it's really
a matter of personal opinion at this point.

Given that there are only a few use cases of "choice" with tri-state
options, it might be just as easy to leave things as is and do with
what we have.

Thanks,
-- 
Jean Delvare
