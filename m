Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUCBXEa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUCBXE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:04:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:56003 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261202AbUCBXEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:04:24 -0500
Subject: Re: [PATCH] ppc32: macserial.c missing variable declaration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403021434040.3000@ppc970.osdl.org>
References: <1078263053.21573.176.camel@gaston>
	 <Pine.LNX.4.58L.0403030014530.30738@alpha.zarz.agh.edu.pl>
	 <Pine.LNX.4.58.0403021434040.3000@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1078267984.28288.204.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Mar 2004 09:53:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This can't be right. Those variables are never initialized anywhere.
> 
> The usage of 'cmd' should either be removed entirely, or it should be 
> passed in as an argument, it looks like. In the meantime, it's better to 
> have code that doesn't compile than code that compiles but can't possibly 
> do anything sane.

macserial is obsolete on 2.6. it should be removed. pmac_zilog is the
replacement.

I still haven't found the bug with pmac_zilog that caused the occasional
crash on boot on the G5 though (it seems to be a subtle race, I haven't
found anything wrong with pmac_zilog itself), but then, I've been
quite busy with other things latey.

Ben.


