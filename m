Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261993AbUEWA16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUEWA16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 20:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUEWA16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 20:27:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:61380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261993AbUEWA15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 20:27:57 -0400
Date: Sat, 22 May 2004 17:27:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: rettw@rtwnetwork.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 high CPU utilization with multimedia apps {Scanned}
Message-Id: <20040522172724.6c804068.akpm@osdl.org>
In-Reply-To: <32847.192.168.0.243.1085236590.squirrel@webmail.rtwsecurenet.com>
References: <32847.192.168.0.243.1085236590.squirrel@webmail.rtwsecurenet.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rettw@rtwnetwork.com wrote:
>
> I have noticed and have read several reports on the net
>  regarding CPU utilization differences (top displays) when
>  running multimedia apps on 2.6 versus late 2.4 kernels. 
>  2.6 running xine/mplayer/vlc etc uses 2-4 times more CPU
>  than 2.4.24 running the very same applications/media. 
>  Some of the CPU appears tied up in the "X" process (I am
>  using the xvideo extension), the rest in the app itself. 
>  I have seen this on every machine I have tested 2.6 on,
>  all with 2Ghz+ CPUs.  I have tested 2.6.4, 2.6.5, 2.6.6
>  vanilla kernels from kernel.org

This could be an artifact from the instrumentation - if the application is
doing short bursts of work the 1000Hz clock may be providing more accurate
sampling.

In 2.6, edit include/asm/param.h and set HZ to 100 and then redo the
measurement.

