Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268872AbTBZTmD>; Wed, 26 Feb 2003 14:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268876AbTBZTmD>; Wed, 26 Feb 2003 14:42:03 -0500
Received: from fmr06.intel.com ([134.134.136.7]:34762 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S268872AbTBZTmC>; Wed, 26 Feb 2003 14:42:02 -0500
Subject: Re: [2.5.63 PATCH][TRIVIAL]Change rtc.c ioport extend from 10h to 8h
From: Rusty Lynch <rusty@linux.co.intel.com>
To: root@chaos.analogic.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, p_gortmaker@yahoo.com,
       lkml <linux-kernel@vger.kernel.org>, rddunlap@osdl.org
In-Reply-To: <Pine.LNX.3.95.1030226142828.5091A-100000@chaos>
References: <Pine.LNX.3.95.1030226142828.5091A-100000@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Feb 2003 11:42:30 -0800
Message-Id: <1046288552.4450.13.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 11:35, Richard B. Johnson wrote:
> On 26 Feb 2003, Rusty Lynch wrote:
> 
> > The real time clock only needs 8 bytes, but rtc.c is reserving 10h bytes.
> [SNIPPED...]
> 
> It only needs two bytes port 0x70 and port 0x71 in ix86. Since the Sparc
> gets addressed differently and can only read/write words, it needs 8
> bytes.  Please, if you are going to fix it, please fix it only once by
> setting a different length for the different machines!
> Cheers,
> Dick Johnson

Actually, it's finer grain then x86, it's a chipset issue.  As Randy
pointed out in the original thread ==>
> Some Intel chipset specs list RTC as using 0x70 - 0x77, probably with
> some aliasing in there, so it looks to me like an EXTENT of 8 would be
> safer and still allow you access to 0x79.
> 
> I'm looking at 82801BA-ICH2, 82801-ICH3, and 82801AA-ICH0 specs.
> 
> -- 
> ~Randy
> 

Any suggestions on the right way of doing this?

   --rustyl

