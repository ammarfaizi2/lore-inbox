Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbSJWRL7>; Wed, 23 Oct 2002 13:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265102AbSJWRL7>; Wed, 23 Oct 2002 13:11:59 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:1216 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265096AbSJWRL6>; Wed, 23 Oct 2002 13:11:58 -0400
Subject: Re: 2.5 Problem Report Status
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick Mochel <mochel@osdl.org>
Cc: jbradford@dial.pipex.com, tmolina@cox.net, erik@debill.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210230952311.983-100000@cherise.pdx.osdl.net>
References: <Pine.LNX.4.44.0210230952311.983-100000@cherise.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 18:34:34 +0100
Message-Id: <1035394474.4319.76.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 18:03, Patrick Mochel wrote:
> Concerning the actual shutdown, I'm simply calling the ide driver's 
> ->standby() method. At least in the case of ide disks, there is a call in 
> the driver's ->cleanup() method to flush the cache. Should this be 
> moved to ->standby()? Or, should we call ->flushcache() for all drives 
> from ->shutdown()? 

I'll take a look. I need to finish porting over the 2.4 shutdown/eject
locking fixes that also touch this area

