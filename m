Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDRJ2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDRJ2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 05:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDRJ2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 05:28:03 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:27293 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750712AbWDRJ2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 05:28:02 -0400
Date: Tue, 18 Apr 2006 11:28:01 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Liu haixiang <liu.haixiang@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on Schedule and Preemption
Message-ID: <20060418092801.GC7258@rhlx01.fht-esslingen.de>
References: <bf3792800604180023r2a2111b4ude5ef15f9dd855a@mail.gmail.com> <20060418091724.GA7258@rhlx01.fht-esslingen.de> <1145352228.2976.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145352228.2976.18.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 18, 2006 at 11:23:47AM +0200, Arjan van de Ven wrote:
> 
> > If the current task is running and thus not yet exiting (!current->exit_state)
> > and is also in an atomic code section (i.e. under lock), it shouldn't call
> > any reschedule function (which also happens by just calling msleep(): use
> > mdelay() instead in that case!).
> > 
> 
> actually don't use mdelay, but change your code so that you CAN sleep :)

Ermm, I meant to say that, but forgot to do so clearly, sorry.

Basically long delays while holding locks are also a very baaad thing,
thus always avoid delays as much as possible there.

Andreas Mohr

-- 
No programming skills!? Why not help translate many Linux applications! 
https://launchpad.ubuntu.com/rosetta
(or alternatively buy nicely packaged Linux distros/OSS software to help
support Linux developers creating shiny new things for you?)
