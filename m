Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVG3Sui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVG3Sui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbVG3Sui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:50:38 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:12148 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261428AbVG3SuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:50:25 -0400
Date: Sat, 30 Jul 2005 20:52:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050730185226.GA9334@mars.ravnborg.org>
References: <20050730165202.GI5590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730165202.GI5590@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 06:52:02PM +0200, Adrian Bunk wrote:
> Currently, using an undeclared function gives a compile warning, but it 
> can lead to a link or even a runtime error.
> 
> With -Werror-implicit-function-declaration, we are getting an immediate 
> compile error instead.
For i386 this is pretty OK.
But what about other architectures?

Before applying this change I want to know the result on a few archs,
and anyway using a CONFIG option may be a safer choice for a while.

> 
> This patch also removes some unneeded spaces between two tabs in the 
> following line.
Please - use tabs for indention, not for alignment.
The below would look rather messy with tabs=4.
Almost everywhere tabs are used in Makefiles it is plina wrong.
Tabs are brillient for indention but you cannot just assume 8 spaces = a
tab. Not even at the beginning of the line.

If you have a nested if or something tabs are there to be used.

	Sam
