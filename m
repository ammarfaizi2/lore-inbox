Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317535AbSGTVSe>; Sat, 20 Jul 2002 17:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317536AbSGTVSe>; Sat, 20 Jul 2002 17:18:34 -0400
Received: from ip68-100-183-147.nv.nv.cox.net ([68.100.183.147]:42425 "HELO
	ascellatech.com") by vger.kernel.org with SMTP id <S317535AbSGTVSc>;
	Sat, 20 Jul 2002 17:18:32 -0400
Message-ID: <1027200088.3d39d4587cc66@192.168.101.69>
Date: Sat, 20 Jul 2002 17:21:28 -0400
From: Amith Varghese <amith@xalan.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-2.4.19-rc1-ac4 + Promise SX6000 + i2o
References: <1026941364.4547.91.camel@viper>  <1026966681.4537.119.camel@viper>  <1027048267.4537.185.camel@viper> <1027197568.16818.23.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1027197568.16818.23.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 192.168.101.71
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So does this mean that the item mentioned in the 2.4.19-rc1-ac3 changelog will 
not work because the 2.4.19 base tries to initialize the drive first? Or is 
the -ac tree immune to this problem?

o        Newer SX6000 has PDC20276 chips. Handle this 

If that is the case, I guess I have to use the promise drivers.  However, i'll 
offer free beer if anyone can help me get the i2o driver to work :)

Thanks
Amith


Quoting Alan Cox <alan@lxorguk.ukuu.org.uk>:

> On Fri, 2002-07-19 at 04:11, Amith Varghese wrote:
> > Ok, I am still having problems booting 2.4.19-rc2-ac2.... I get an APIC
> > error on CPU0 (and CPU1).  However, I tried 2.4.19-rc2 with my Promise
> > SX6000 and get a slightly different result than 2.4.18.  It almost looks
> > like the hard drives attached to the promise sx6000 are being
> > initialized before it gets to the i2o code and the i2o block driver is
> > unable to initialize /dev/i2o/hda (but thats a wild guess from my
> 
> They are. 2.4.19 base doesn't yet avoid them it seems. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



