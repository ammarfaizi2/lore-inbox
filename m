Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVLaSgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVLaSgh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVLaSgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 13:36:37 -0500
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:11782 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932084AbVLaSgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 13:36:36 -0500
Date: Sat, 31 Dec 2005 19:39:56 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Roman Zippel <zippel@linux-m68k.org>, Linus Torvalds <torvalds@osdl.org>,
       Ricardo Cerqueira <v4l@cerqueira.org>, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: Recursive dependency for SAA7134 in 2.6.15-rc7
Message-Id: <20051231193956.4271e2f0.khali@linux-fr.org>
In-Reply-To: <1135949941.25274.1.camel@localhost>
References: <20051227215351.3d581b13.khali@linux-fr.org>
	<200512292100.27536.zippel@linux-m68k.org>
	<20051229211350.4115b799.khali@linux-fr.org>
	<200512292119.10139.zippel@linux-m68k.org>
	<20051229220730.1c22b1a4.khali@linux-fr.org>
	<1135936882.7465.18.camel@localhost>
	<20051230120607.47951ec6.khali@linux-fr.org>
	<1135949941.25274.1.camel@localhost>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

Sorry for the delay.

> > Can you please rebase it on Linus' latest (2.6.15-rc7-git4)? So that I
> > can give it a try...
> 	Updated.

I tried it, it works, but I like it less than the current approach.
Being able to select "Philips SAA7134 DMA audio support" as a module
while it doesn't correspond to real code is a bit confusing. Not being
able to unselect it completely is confusing as well. Thinks go even
worse when only ALSA or OSS has been selected in the general sound
menu, as you end up with a complex layout for no reason.

So I believe that "choice" is an interesting Kconfig feature when used
with boolean options, but with modules I am not convinced, especially
when these modules have different dependencies.

So if I were to decide, I would stick to the current code. But I am
obviously not the one to decide here.

Thanks,
-- 
Jean Delvare
