Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317349AbSHYNNw>; Sun, 25 Aug 2002 09:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSHYNNw>; Sun, 25 Aug 2002 09:13:52 -0400
Received: from mail.zmailer.org ([62.240.94.4]:28863 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317349AbSHYNNv>;
	Sun, 25 Aug 2002 09:13:51 -0400
Date: Sun, 25 Aug 2002 16:18:04 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: joerg.beyer@email.de
Cc: ZwaneMwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: big IRQ latencies, was:  <no subject>
Message-ID: <20020825131804.GV10011@mea-ext.zmailer.org>
References: <200208251238.g7PCcxX03888@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208251238.g7PCcxX03888@mailgate5.cinetic.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 02:38:59PM +0200, joerg.beyer@email.de wrote:
> Zwane Mwaikambo <zwane@linuxpower.ca> schrieb am 25.08.02 14:10:12:
> > On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:
> ...
> > That should fix your slowdown during untarring/disk access, as for your 
> > NIC problem looks like you might be having a receive FIFO overflow, so 
> > perhaps the card stops processing incoming packets? I have no clue, 
> 
> maybe this helps: outgoing transfer (from the laptop to some
> other machine) is reasonable fast: I could copy gig's of data
> away, but not to the machine. I asume sending away makes not
> so heavy use of IRQ's, right?

A laptop, you say ?   And network reception is jamming while
there is high disk-write activity ?

  /sbin/hdparam -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)  <-----  ??
 unmaskirq    =  1 (on)      <-----  ??
 using_dma    =  1 (on)      <-----  ??
 keepsettings =  1 (on)      <-----  ??
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)


>     does this help?
>     Joerg
> 
> ps: sorry for the missing subjectline

/Matti Aarnio
