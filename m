Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUEUX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUEUX6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUEUXva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:51:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:39613 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264375AbUEUXdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:33:01 -0400
Date: Thu, 20 May 2004 11:43:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Jinu M." <jinum@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       "Surendra I." <surendrai@esntechnologies.co.in>
Subject: Re: protecting source code in 2.6
In-Reply-To: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.53.0405201128460.3465@chaos>
References: <1118873EE1755348B4812EA29C55A97222FD0D@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004, Jinu M. wrote:

> Hi All,
>
> We are developing a block device driver on linux-2.6.x kernel. We want
> to distribute our driver as sum of source code and librabry/object code.
>
[SNIPPED...]

If it executes INSIDE the kernel, i.e., becomes part of a module,
it executes with no protection whatsoever. It is, therefore,
capable of destroying anything in the kernel including anything
the kernel can touch. Therefore, such a secret blob of code
can destroy all the user's work. It can even propagate to other
machines over the network and infect them. In short, it can
be a worm, Trojan Horse, or other dangerous, even "Microsoft-like"
infection. If it's not, it will be blamed anyway.

There are no secret methods of interfacing to proprietary
hardware. One can only use the methods provided by the target
CPU and its associated hardware components. Anybody who thinks
that their hardware interface code represents protected intellectual
property doesn't have a clue what intellectual property is.

If you have some magic unpublished algorithms in your driver,
they shouldn't be there. They should be in a user-mode library
that interfaces with the driver. In this manner, you keep your
secret algorithms to yourselves, protecting your intellectual
property, while publishing your interface code that executes,
unprotected, in the kernel.

So, either provide the source-code for your driver or go away.
There are very few persons who will allow you to insert secret
code into their kernels where it could destroy everything of
value to them.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


