Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRBLWst>; Mon, 12 Feb 2001 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129422AbRBLWsk>; Mon, 12 Feb 2001 17:48:40 -0500
Received: from dspnet.claranet.fr ([212.43.196.92]:34574 "HELO
	dspnet.claranet.fr") by vger.kernel.org with SMTP
	id <S129112AbRBLWsJ>; Mon, 12 Feb 2001 17:48:09 -0500
Date: Mon, 12 Feb 2001 23:48:03 +0100
From: Jean-Luc Leger <reiga@dspnet.claranet.fr>
To: linux-kernel@vger.kernel.org
Subject: mispellings and other preprocessing problems
Message-ID: <20010212234803.A17684@dspnet.claranet.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am a computer scientist from France. I currently play with
a source code analyser of mine.
 
Here are some "bugs" (or are they not ?) it detected :
(my own comments begin with ->)
 
/usr/src/linux-2.4.1/include/asm-parisc/som.h : EOF in comment
-> this one is self explained ..

/usr/src/linux-2.4.1/drivers/char/dz.c : 233    IDENTIFIER expected in #ifdef
-> line 233 is : #ifdef 0
-> maybe #if 0 ? (and then, it is not so important since cpp understand it
->  correctly)

/usr/src/linux-2.4.1/arch/ia64/sn/io/klgraph_hack.c : 
 142       IDENTIFIER expected in #ifdef
-> same thing with #ifdef 0

/usr/src/linux-2.4.1/drivers/char/joystick/amijoy.c : 
 EOF in string started in line 116
-> unknown identifier 'Denise' (probably should be 'i')
-> unexpected double quote which is the origin of the problem

/usr/src/linux-2.4.1/drivers/scsi/NCR5380.c : 
 2267      NEWLINE expected in #ifdef
-> line 2267 is : #ifdef READ_OVERRUNS if (p & SR_IO) { c -= 2;
-> this line should be split in 2
 
/usr/src/linux-2.4.1/drivers/atm/nicstar.h : 616        unknown directive
/usr/src/linux-2.4.1/drivers/atm/nicstar.h : 628        unknown directive
-> #eliif in place of #elif

/usr/src/linux-2.4.1/arch/ia64/sn/io/klconflib.c : 
 514  Constant expression expected in #ifdef
-> closing bracket at wrong position in expression

/usr/src/linux-2.4.1/arch/ia64/sn/io/ml_SN_init.c : 
 351 NEWLINE expected in #ifdef
-> #ifdef CONFIG_SGI_IP35 || CONFIG_IA64_SGI_SN1 || CONFIG_IA64_GENERIC
-> should be : 
-> #if defined (CONFIG_SGI_IP35) || defined(CONFIG_IA64_SGI_SN1) 
       || defined(CONFIG_IA64_GENERIC)


That's all. Of course, I advise those who know to check my corrections :)

Thanks for this interesting system :)

	JLL

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
