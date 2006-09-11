Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWIKGvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWIKGvQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 02:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWIKGvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 02:51:15 -0400
Received: from nef2.ens.fr ([129.199.96.40]:32519 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750713AbWIKGvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 02:51:15 -0400
Date: Mon, 11 Sep 2006 08:51:11 +0200
From: David Madore <david.madore@ens.fr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 3/4] security: capabilities patch (version 0.4.4), part 3/4: introduce new capabilities
Message-ID: <20060911065111.GA4850@clipper.ens.fr>
References: <20060910133759.GA12086@clipper.ens.fr> <20060910134257.GC12086@clipper.ens.fr> <1157905393.23085.5.camel@localhost.localdomain> <450451DB.5040104@gentoo.org> <20060910200337.GA24123@clipper.ens.fr> <Pine.LNX.4.61.0609110807250.14570@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609110807250.14570@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 11 Sep 2006 08:51:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 08:10:17AM +0200, Jan Engelhardt wrote:
> You cannot reasonable run a program without CAP_REG_OPEN, because 
> ld.so, libc.so and libdl.so all may load a ton of required files 
> underneath you.

A program might quite conceivably drop CAP_REG_OPEN willingly once
it's started, or the administrator might use capset() on it once it's
running.  But, again, this cap is mostly a proof of concept: the
really useful ones are CAP_REG_WRITE and CAP_REG_SXID.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
