Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbULUBqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbULUBqj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 20:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULUBqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 20:46:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61059 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261726AbULUBqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 20:46:35 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Dan Dennedy <dan@dennedy.org>,
       Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041220230222.GA21288@stusta.de>
References: <20041220015320.GO21288@stusta.de>
	 <1103508610.3724.69.camel@kino.dennedy.org>
	 <20041220022503.GT21288@stusta.de>
	 <1103510535.1252.18.camel@krustophenia.net>
	 <1103516870.3724.103.camel@kino.dennedy.org>
	 <20041220225324.GY21288@stusta.de>
	 <1103583486.1252.102.camel@krustophenia.net>
	 <20041220230222.GA21288@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103589619.32550.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Dec 2004 00:40:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 23:02, Adrian Bunk wrote:
> > What if the driver is under development and doesn't work yet?
> 
> For a driver developer, it shouldn't be a big problem to re-add an 
> EXPORT_SYMBOL or even to undo an #if 0 of a currently unused function.

Except that the driver author now has to compile entire kernels, can't
redistribute it easily to others for testing without them all rebuilding
the kernel and has no idea of what things the author intended to be API.
In this case it isnt a clean up, but a game plan to reduce the amount
and quality of driver submission. 

On this one you've clearly gone too far. USB had a pile of API functions
before drivers used them, video4linux did the same and that made sense
just like this does.  Tidy it up in 12-18 months when the drivers exist
to know what is worth keeping and what should be removed.

Alan

