Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUENVx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUENVx3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUENVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:53:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:65424 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261791AbUENVv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:51:57 -0400
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kronos <kronos@kronoz.cjb.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040514164154.GA3852@dreamland.darkstar.lan>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	 <1084488901.3021.116.camel@gaston>
	 <20040514164154.GA3852@dreamland.darkstar.lan>
Content-Type: text/plain
Message-Id: <1084571316.31315.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 07:48:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There are 2 arrays at the end of the struct:
> 
> struct radeon_regs {
>         ....
>         u32             palette[256];
>         u32             palette2[256];
> };
> 
> they take 2KB alone and AFAICS they are not used anywhere. Maybe they
> can be removed?

They are the result of some work in progress on my side. I started
adding the entire card state to the structure, but never finished.

I'll probably go back on that when I find time though.

Ben.


