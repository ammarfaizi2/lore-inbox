Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbSKQRai>; Sun, 17 Nov 2002 12:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267530AbSKQRai>; Sun, 17 Nov 2002 12:30:38 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:57729 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267529AbSKQRah> convert rfc822-to-8bit; Sun, 17 Nov 2002 12:30:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.[45] fixes for design locking bug in wait_on_page/wait_on_buffer/get_request_wait
Date: Sun, 17 Nov 2002 18:37:00 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Rodrigo Souza de Castro <rcastro@ime.usp.br>
References: <200211161958.57677.m.c.p@wolk-project.de> <200211162235.39620.m.c.p@wolk-project.de>
In-Reply-To: <200211162235.39620.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211171832.12855.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 November 2002 22:55, Marc-Christian Petersen wrote:

Hi Andrea,

> Andrea, this makes a difference! The pausings are much less than before,
> but still occur. Situation below.
So, after some time in trying to exchange 2.4.20-rc2 files with the following 
files from 2.4.18 (and compile successfully)

drivers/block/ll_rw_blk.c
drivers/block/elevator.c
include/linux/elevator.h

those "pauses/stopps" are _GONE_!

I've also tested all this situations with totally different mashines. No 
changes, all behaves the same.

I am really afraid that no one else (seems so) noticed this but me! I cannot 
believe that?! :-(

It is a really serious "bug" I cannot live with. Doing that high disk i/o and 
even pings are ignored for the amount of time the stop occurs, is an 
absolutely inacceptable situation! *imho*

What do you think? :-)

ciao, Marc
