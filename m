Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUALMqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 07:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266165AbUALMqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 07:46:17 -0500
Received: from [212.239.225.130] ([212.239.225.130]:3201 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S266161AbUALMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 07:46:05 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Kiko Piris <kernel@pirispons.net>
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Date: Mon, 12 Jan 2004 13:45:51 +0100
User-Agent: KMail/1.5.4
Cc: Bart Samwel <bart@samwel.tk>, linux-kernel@vger.kernel.org,
       Dax Kelson <dax@gurulabs.com>, Bartek Kania <mrbk@gnarf.org>,
       Simon Mackinlay <smackinlay@mail.com>
References: <3FFFD61C.7070706@samwel.tk> <200401121212.44902.lkml@kcore.org> <20040112121956.GA8226@portsdebalears.com>
In-Reply-To: <20040112121956.GA8226@portsdebalears.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401121345.51506.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 January 2004 13:19, Kiko Piris wrote:
> As you don't say if you have checked it, here goes my suggestion:
>
> First of all, you should assure there's no process doing reads [*] that
> cause a cache miss (eg. daemons like postfix that check the queue every
> few seconds). You can tell this running vmstat 1 and see that bi and bo
> [**] stay at 0.

bi == 0 in 99% of the time. It caused one spinup sofar, and the disk has been 
spun op 10 times sofar.

> [*] Processes making disk writes are supposed to be "harmless", because
> laptop-mode will delay those writes to disk (that's what it's supposed
> to do! ;).

Well, it looks otherwise to me.

Jan
-- 
It's hard to keep your shirt on when you're getting something off your chest.

