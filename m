Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbTCLOow>; Wed, 12 Mar 2003 09:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263199AbTCLOov>; Wed, 12 Mar 2003 09:44:51 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29891
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263195AbTCLOou>; Wed, 12 Mar 2003 09:44:50 -0500
Subject: Re: 2.5.64: i2c-proc kills machine at boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?unknown-8bit?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Deepak Saxena <deepak@plexity.net>
In-Reply-To: <20030312125631.GA27966@wohnheim.fh-wedel.de>
References: <20030311104721.GA401@elf.ucw.cz>
	 <20030312125631.GA27966@wohnheim.fh-wedel.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047484999.22696.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 16:03:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 12:56, =?unknown-8bit?Q?J=F6rn?= Engel wrote:
> On Tue, 11 March 2003 11:47:22 +0100, Pavel Machek wrote:
> > 
> > If I turn #ifdef DEBUG in i2c_register_entry() into #if 1, it prints 
> > 
> > i2c-proc.o: NULL pointer when trying to install fill_inode fix!\n
> > 
> > but boots.
> 
> That file need a lot of work anyway. On the shitlist of top stack
> users, it holds ranks 3 and 9-11. Impressive.

His problem is i2c not i2o. Also the i2o proc stuff while ugly isnt a
deep call nest or in irq context so not a big problem. It does want
fixing but thats a seperate matter

> It also isn't listed in the current MAINTAINERS file. Is i2o currently
> unmaintained?

Its kind of mine. Maintained is an overly strong word for it however, but I 
do take patches 8)

