Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbTLPFTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 00:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264948AbTLPFTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 00:19:45 -0500
Received: from host3.steam.com ([69.36.241.230]:59857 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S264910AbTLPFTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 00:19:44 -0500
Date: Mon, 15 Dec 2003 21:20:34 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
Message-ID: <20031216052034.GI70731@gaz.sfgoth.com>
References: <1071126929.5149.24.camel@idefix.homelinux.org> <1293500000.1071127099@[10.10.2.4]> <20031212220853.GA314@elf.ucw.cz> <1071269849.4182.14.camel@idefix.homelinux.org> <20031212234028.GA541@elf.ucw.cz> <1071543853.989.183.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071543853.989.183.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Indeed, with all the trouble HZ==1000 has caused, I'm thinking that
> playing w/ HZ at 10k and 10 would be good stress tests for the time
> subsystem.

I think setting HZ much lower than 100 might break some drivers that
do things like:
		timeout = jiffies + (HZ / 50);

Not sure if any of the common drivers have this problem but be on the
lookout for it if you want to try running w/ really low HZ.

I suppose there should really be a "FRACTION_OF_SECOND()" macro or something
that always returns >0 for specifying these really short delays.

-Mitch
