Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVHOQnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVHOQnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVHOQnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:43:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20177 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964839AbVHOQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:43:23 -0400
Date: Mon, 15 Aug 2005 17:43:20 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: yhlu <yhlu.kernel@gmail.com>
cc: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>,
       Jim Ramsay <jim.ramsay@gmail.com>, alex.kern@gmx.de,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Atyfb questions and issues
In-Reply-To: <86802c4405081211153ec42f7e@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0508151741510.7300@pentafluge.infradead.org>
References: <Pine.LNX.4.44.0508121918200.10526-100000@deadlock.et.tudelft.nl>
  <Pine.LNX.4.56.0508121848040.30829@pentafluge.infradead.org>
 <86802c4405081211153ec42f7e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> james,
> 
> I remember that xlinit in 2.6 kernel only works when BIOS option-rom
> really init fb.
> It can not work if the BIOS option rom is not executed.
> 
> For 2.4, it reversed, it can not work if BIOS opton-rom is executed.
> Only work if BIOS don't excute the option rom.

You are right. The init_from_bios is called on x86 in aty_setup_generic 
before aty_init which calls the biosless initialization. The question is 
what needs to be done to properly fix it?

