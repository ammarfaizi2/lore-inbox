Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVCXHkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVCXHkD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbVCXHkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:40:02 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:25188 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262426AbVCXHji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:39:38 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/5] I8K driver facelift
Date: Thu, 24 Mar 2005 02:39:32 -0500
User-Agent: KMail/1.7.2
Cc: Frank Sorenson <frank@tuxrocks.com>, LKML <linux-kernel@vger.kernel.org>,
       Valdis.Kletnieks@vt.edu
References: <200502240110.16521.dtor_core@ameritech.net> <200503170140.49328.dtor_core@ameritech.net> <20050324072550.GL10604@kroah.com>
In-Reply-To: <20050324072550.GL10604@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240239.32639.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 March 2005 02:25, Greg KH wrote:
> On Thu, Mar 17, 2005 at 01:40:48AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 16 March 2005 16:38, Frank Sorenson wrote:
> > > Okay, I replaced the sysfs_ops with ops of my own, and now all the show
> > > and store functions also accept the name of the attribute as a parameter.
> > > This lets the functions know what attribute is being accessed, and allows
> > > us to create attributes that share show and store functions, so things
> > > don't need to be defined at compile time (I feel slightly evil!).
> > 
> > Hrm, can we be a little more explicit and not poke in the sysfs guts right
> > in the driver? What do you think about the patch below athat implements
> > "attribute arrays"? And I am attaching cumulative i8k patch using these
> > arrays so they can be tested.
> > 
> > I am CC-ing Greg to see what he thinks about it.
> 
> Hm, I think it's proably of limited use, right?  What other code would
> want this (the i2c sensor code doesn't, as it's naming scheme is
> different.)
>

Looking at their attributes they would benefit from arrays of goups of
attributes... They have:

temp[1-4]_max
temp[1-3]_min
temp[1-3]_max_hyst

It could be:

temp/<n>/max
         min
         max_hyst


-- 
Dmitry
