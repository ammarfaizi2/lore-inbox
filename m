Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSLTMph>; Fri, 20 Dec 2002 07:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbSLTMph>; Fri, 20 Dec 2002 07:45:37 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:13831 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261872AbSLTMph>; Fri, 20 Dec 2002 07:45:37 -0500
Date: Fri, 20 Dec 2002 15:53:11 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: davidm@hpl.hp.com
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021220155311.A22437@jurassic.park.msu.ru>
References: <20021219213712.0518B12CB2@debian.cup.hp.com> <atubg3$699$1@penguin.transmeta.com> <15874.58889.846488.868570@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15874.58889.846488.868570@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Fri, Dec 20, 2002 at 01:42:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 01:42:33AM -0800, David Mosberger wrote:
>  If certain bridges cause
> problems, perhaps those need to be special-cased?

Couple of days ago I mindlessly suggested exactly that, but I
take it back.
Not only *all* classes of bridges would be special-cased:
turning off IO and MEM in the PCI command register disables the legacy I/O
ports and memory on some VGAs. Guess what happens if someone decides
to printk in the meantime.

Ivan.
