Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSICUi7>; Tue, 3 Sep 2002 16:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSICUi7>; Tue, 3 Sep 2002 16:38:59 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:21487
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318608AbSICUi7>; Tue, 3 Sep 2002 16:38:59 -0400
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Hacksaw <hacksaw@hacksaw.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0209031423260.3373-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209031423260.3373-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 03 Sep 2002 21:45:08 +0100
Message-Id: <1031085908.21439.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 21:34, Thunder from the hill wrote:
> Well, I'm talking about a vision of replacing partition tables with 
> sensible and gentle disk handling, where possible. Old technics definitely 
> need some other kind of hammer, or to get replaced.

And what about all the firmware that needs PC partition tables ? They
won't be going away in a hurry even as/if EFI replaces the DOS partition
format. More likely we'll get superextendedwhizzopartition types and a
hack on a hack of the origina DOS ones.

> > But more importantly, I want controllers that survive total power down.
> 
> You can't get that with partition tables either. And by the way, we 
> succeeded doing that at Magdeburg. Pull out the power supply, batteries, 
> etc., then run away.

Why not - you can journal partition updates too. There are systems out
there that do it, even ones that do cluster safe partition management on
the fly.

If you want to do partitions in user space and play with the idea the
LVM2 code is very clean, very nice and already provides you with
everything needed to do it nicely.

