Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267356AbUIATIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267356AbUIATIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267415AbUIATIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:08:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:26082 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267356AbUIATIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:08:37 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <lkml@rtr.ca>, bzolnier@milosz.na.pl,
       Greg Stark <gsstark@mit.edu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       tim.bird@am.sony.com, dsingleton@mvista.com
In-Reply-To: <1094051215.2777.15.camel@localhost.localdomain>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <200408272005.08407.bzolnier@elka.pw.edu.pl>
	 <1093630121.837.39.camel@krustophenia.net>
	 <200408272059.51779.bzolnier@elka.pw.edu.pl>  <4135CC9E.5060905@rtr.ca>
	 <1094051215.2777.15.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1094065718.1970.39.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 01 Sep 2004 15:08:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 11:06, Alan Cox wrote:
> On Mer, 2004-09-01 at 14:20, Mark Lord wrote:
> > LBA48 is only needed when (1) the sector count is greater than 256,
> > and/or (2) the ending sector number >= (1<<28).
> 
> I've played with this a bit and in the -ac IDE code it can drop back
> to LBA28 for devices that are small enough not to need LBA48 when the
> controller only supports PIO for LBA48 modes (eg some ALi) as 2.4-ac
> did. 
> 
> > I regularly include this optimisation in the drivers I have been
> > working on since LBA48 first appeared.
> 
> It isn't always a win. You get cut down to 256 sectors per I/O which for
> some workloads has a cost and you need to factor that into the command
> issue choice as well as the last sector number being accessed.
> 

I have never been able to measure a decrease in disk throughput in any
disk benchmark with 256 sectors per I/O vs. 1024.  This is a modestly
powered desktop with a single drive though.  What kinds of workloads
would you expect to be affected by this?

Lee 

