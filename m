Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288116AbSBMSof>; Wed, 13 Feb 2002 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSBMSoZ>; Wed, 13 Feb 2002 13:44:25 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:7307 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288420AbSBMSoQ>;
	Wed, 13 Feb 2002 13:44:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: How to check the kernel compile options ?
Date: Wed, 13 Feb 2002 19:26:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Bill Davidsen <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0202130857320.1530-200000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0202130857320.1530-200000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b46V-0002OD-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 07:09 pm, Randy.Dunlap wrote:
> On Wed, 13 Feb 2002, Richard B. Johnson wrote:
> 
> | On Wed, 13 Feb 2002, Horst von Brand wrote:
> |
> | > Daniel Phillips <phillips@bonn-fries.net> said:
> | > > On February 12, 2002 05:38 pm, Bill Davidsen wrote:
> | >
> | > [...]
> | [SNIPPED...]
> |
> | My idea is to take the .config file and remove most of its
> | redundancy and unnecessary verbage. Then, the result is
> | compressed and written to a constant global array, linked
> | into the kernel. Both the array and the array length will then
> | be available from /proc/kcore for user-mode tools to recreate the
> | .config file.
> 
> This is a bit similar to what I did last weekend (and attach
> here).  Mine goes into the kernel boot file, however, so that
> it can be read even when the kernel isn't running.
> 
> I'll experiment with ideas from Andreas (thanks) or Ian Soboroff
> to create a userspace get-config tool.
> 
> One small nit:  you say "user-mode tools", but /proc/kcore
> is read-only for root only -- right?
> That's not desirable or required IMO.

Binary proc or a char device would be a much better idea, and of those
binary proc seems the most elegant, something like:

  cat /proc/binary/kernel/config | kernelconfig > .config

-- 
Daniel
