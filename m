Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSIOE1Z>; Sun, 15 Sep 2002 00:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSIOE1Z>; Sun, 15 Sep 2002 00:27:25 -0400
Received: from dsl-213-023-043-058.arcor-ip.net ([213.23.43.58]:33952 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317751AbSIOE1Y>;
	Sun, 15 Sep 2002 00:27:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, Nicholas Miell <nmiell@attbi.com>
Subject: Re: [patch] dump_stack(): arch-neutral stack trace
Date: Sun, 15 Sep 2002 06:34:50 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0209091714330.2069-100000@penguin.transmeta.com> <1031618129.1403.12.camel@entropy> <3D7D447B.D7BD1C33@digeo.com>
In-Reply-To: <3D7D447B.D7BD1C33@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qR7T-0001qf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 03:01, Andrew Morton wrote:
> From Christoph Hellwig, also present in 2.4.
> 
> Create an arch-independent `dump_stack()' function.  So we don't need to do
> 
> #ifdef CONFIG_X86
> 	show_stack(0);		/* No prototype in scope! */
> #endif
> 
> any more.
> 
> The whole dump_stack() implementation is delegated to the architecture.
> If it doesn't provide one, there is a default do-nothing library
> function.

Is there a reason for not calling it "backtrace()" ?

-- 
Daniel
