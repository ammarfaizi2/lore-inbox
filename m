Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbULTVGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbULTVGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbULTVGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:06:05 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:65430 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261641AbULTVGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:06:00 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Lee Revell <rlrevell@joe-job.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arne Caspari <arnem@informatik.uni-bremen.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20041220175156.GW21288@stusta.de>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <20041220175156.GW21288@stusta.de>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 16:05:58 -0500
Message-Id: <1103576759.1252.93.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 18:51 +0100, Adrian Bunk wrote:
> > Please please, do not break the kernel API out of the blue. Supporting a 
> > Linux driver is already very frustrating. Currently it is a lot more 
> > convenient for our customers to switch to Windows just because the 
> > installation and use of the software is much easier there - or at least 
> > it is easy enough there to handle the installation where it is not on Linux.
> > 
> > Breaking the API now will most likely stop The Imaging Source from 
> > supporting open source driver development anymore. We just can not 
> > effort any unneccessary development anymore. We are already blocked by 
> > shortcomings in the LDM and bugs in the Linux driver handling ( see my 
> > posings about a hotplugging issue and about the issue that IEEE-1394 
> > modules can not be unloaded ).
> 
> the perfect solution would be if you'd simply submit your driver for 
> inclusion in the main kernel.
> 
> After grepping through your CVS sources, it seems hpsb_read and 
> hpsb_write are the EXPORT_SYMBOLS affecting you?
> So keeping them should address your concerns?

Please, can't you just hold off on breaking the ieee1394 API at all for
now?  Currently there are no supported IEEE-1394 audio devices.  This is
a big deal as most new pro audio interfaces are IEEE-1394 devices.
There are a few under development, see http://freebob.sf.net.  But they
don't work yet.  If you rip out half the API you will make it that much
harder for these developers, by requiring them to be kernel hackers as
well as driver writers.

How about waiting until there is _one_ IEEE-1394 audio driver in the
tree before breaking the API?

Lee

