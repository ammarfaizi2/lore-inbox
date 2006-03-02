Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWCBVKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWCBVKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWCBVKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:10:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:11442 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932545AbWCBVKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:10:22 -0500
Date: Thu, 2 Mar 2006 22:10:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] allow hard links to directories, opt-in for any
 filesystem
In-Reply-To: <440502F3.7020203@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0603022207440.13101@yvahk01.tjqt.qr>
References: <200602281657.k1SGvKFk026965@laptop11.inf.utfsm.cl>
 <440502F3.7020203@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I know why unix didn't allow loops in the filesystem tree. I'm just
> saying that you have to justify a feature before adding it. If he was
> able to nicely solve problems with loops and show some application
> that benefits from it, then it could be considered for Linux.
>

It's bad IMO. Consider someone doing `ln . foo`. Find algorithms could not 
stop, because they would be recursing until 1. dawn 2. PATH_MAX is reached 
3. a user option says so (e.g. -maxdepth). Symlinks provide at least one 
way to know when not to endlessy dive into directories.


Jan Engelhardt
-- 
