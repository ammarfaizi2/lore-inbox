Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSFQPMX>; Mon, 17 Jun 2002 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314546AbSFQPMW>; Mon, 17 Jun 2002 11:12:22 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:720 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314514AbSFQPMU>; Mon, 17 Jun 2002 11:12:20 -0400
Date: Mon, 17 Jun 2002 10:12:21 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Kristian Peters <kristian.peters@korseby.net>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: isdn oops with 2.4.19-pre10
In-Reply-To: <20020617092214.03789a68.kristian.peters@korseby.net>
Message-ID: <Pine.LNX.4.44.0206171009550.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Kristian Peters wrote:

> I tried to unload the isdn modules (I'm using a hisax and a avm b1 
> card) and get these oopses:

Okay, I think I can see what is happening.

Can you confirm that you get the oops if you unload the modules in the 
same order that you loaded them, but not if you use the reverse order?

I.e.

	insmod capidrv; insmod hisax; rmmod hisax; rmmod capidrv

should be okay,

	insmod capidrv; insmod hisax; rmmod capidrv; rmmod hisax

oopses?

--Kai


