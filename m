Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSICPxK>; Tue, 3 Sep 2002 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSICPxK>; Tue, 3 Sep 2002 11:53:10 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:29934
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317081AbSICPwl>; Tue, 3 Sep 2002 11:52:41 -0400
Subject: Re: Scary SCSI disk error message
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: "Jeffrey J. Kosowsky" <jeff.kosowsky@verizon.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209030922490.3270-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0209030922490.3270-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 03 Sep 2002 16:57:59 +0100
Message-Id: <1031068679.21439.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 16:23, Thunder from the hill wrote:
> Hi,
> 
> On Tue, 3 Sep 2002, Jeffrey J. Kosowsky wrote:
> > I am running a pretty standard RH7.3 configuration (Kernel 2.4.18)
> > with root and key filesystems on a 20Gig  EIDE disk. 
> 
> I think we fixed that for 2.4.19.

I don't

The problem he is reporting is also on the SCSI side. Now two things
have changed over time

#1 The 2.4 scsi driver (Justin's notably so) is more aggressive than 2.0
ever was about speeds. It will pick Ultra80 or Ultra160 if the bus
appears capable and the drives do. The old 2.0 code probably never
picked anything more enterprising than 20Mhz.

That does mean that marginal termination will show up when it was
apparently ok both in Linux and in older windows which was also
generally rather conservative

#2 Its a newer driver. aic7xxx_old is the driver we used to use and
trying that might be informative too.


