Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSKTQqr>; Wed, 20 Nov 2002 11:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSKTQqr>; Wed, 20 Nov 2002 11:46:47 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:40936 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S261450AbSKTQqq>; Wed, 20 Nov 2002 11:46:46 -0500
Date: Wed, 20 Nov 2002 17:53:50 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: Karsten Desler <soohrt@soohrt.org>
Cc: u.wiederhold@gmx.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021120175350.A6312@pc9391.uni-regensburg.de>
References: <20021119105955.A23008@pc9391.uni-regensburg.de> <20021119102338.GA24510@sit0.ifup.net> <20021119113300.C23008@pc9391.uni-regensburg.de> <20021119152244.GA26989@sit0.ifup.net> <20021119180317.A2597@pc9391.uni-regensburg.de> <20021119193530.GA915@sit0.ifup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021119193530.GA915@sit0.ifup.net>; from soohrt@soohrt.org on Tue, Nov 19, 2002 at 20:35:30 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2002   20:35 Karsten Desler wrote:
> > okay, my brain really shrinks; with only one hdd attached, you can't create
> an
> > array. So here it seems to work out of the box. I just tried 2.4.20-rc-ac1,
> 
> > which detects my drive connected to that hpt374 (hde).
> >
> > Maybe you can give this one a try?
> 
Karsten,

so today I added 4 more drives to my hpt374, tried 2.5.47-ac6 and works 
flawlessy...
Sorry, but I can't try 2.4-ac-latest, cause of missing xfs support.

There are some things you could be bitten with:
My Distribution (Debian) only ships with device names up to /dev/hdh ...

So, by default, you'll see the drives attached to ide4(hdi,j) and to 
ide5(hdk,l) in the kernel messages, but you can't use 'em...

You have to make device nodes yourself:

mknod /dev/hd* b MAJOR MINOR

where:
hdi : 56 0
hdi1: 56 1
...

hdj : 56 64
hdj1: 56 65
...

hdk : 57 0
hdk1: 57 1
...

hdl : 57 64
hdl1: 57 65
...

see Documentation/devices.txt in the linux kernel sources.

hope this helps for ya!
Good Luck
CHristian





