Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133021AbRDRFca>; Wed, 18 Apr 2001 01:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133022AbRDRFcU>; Wed, 18 Apr 2001 01:32:20 -0400
Received: from adsl-151-196-236-199.baltmd.adsl.bellatlantic.net ([151.196.236.199]:30195
	"EHLO vaio.greennet") by vger.kernel.org with ESMTP
	id <S133021AbRDRFcM>; Wed, 18 Apr 2001 01:32:12 -0400
Date: Wed, 18 Apr 2001 01:31:49 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: battata chafik <battata.chafik@cyberacble.fr.sgi.com>
cc: andrewm@uow.edu.au, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: thank's for answering 
In-Reply-To: <3ADCB4C3.18BB41CB@noos.fr>
Message-ID: <Pine.LNX.4.10.10104180127270.1305-100000@vaio.greennet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, battata chafik wrote:

> i have a 3c595TX card and when i plus it in my hub it at 10base T i
> tride to put the new modules and nothing changed i have a 2.2.16 kernel
> and 2.4.1 kenel and it's the same in the too cases ,
> and i have to other computer using a 100base T cards from real tek and
> they  appear at 100 base T in the hub and te rate of any fule transfert
> is up to 10 mb/s  between the to other computer , so is there any
> upgrade to do for the bios of the nic card or is it normal " i don't
> think so but why not "

First problem: the EEPROM is set to forced full duplex.
This is almost certainly wrong for your hub.

The speed problem is likely because you have a dual speed repeater.  The
595 speed autosensing must be done by the driver.  In order to not screw
up 10baseT repeaters with 100baseTx link beat the driver first sets the
speed to 10baseT and checks for link beat.  If it finds 10baseT link
beat it never tries 100baseTx.

The solution is to set the speed to 100baseTx using a driver option.
Read
   http://www.scyld.com/network/vortex.html

The 3c595 is a very old card.
You will get better performance from any modern card.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

