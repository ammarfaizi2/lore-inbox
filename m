Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTH0RIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTH0RIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:08:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:26537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263435AbTH0RIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:08:14 -0400
Date: Wed, 27 Aug 2003 10:07:45 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: LGW <large@lilymarleen.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: porting driver to 2.6, still unknown relocs... :(
Message-Id: <20030827100745.0d944f33.shemminger@osdl.org>
In-Reply-To: <1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
References: <3F4CB452.2060207@lilymarleen.de>
	<20030827081312.7563d8f9.rddunlap@osdl.org>
	<3F4CCF85.1020502@lilymarleen.de>
	<1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2003 16:59:38 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Mer, 2003-08-27 at 16:34, LGW wrote:
> > The driver is mostly a wrapper around a generic driver released by the 
> > manufacturer, and that's written in C++. But it worked like this for the 
> > 2.4.x kernel series, so I think it has something todo with the new 
> > module loader code. Possibly ld misses something when linking the object 
> > specific stuff like constructors?
> 
> The new module loader is kernel side, it may well not know some of the
> C++ specific relocation types. 

You did something that was explicitly not supported on 2.4 and it worked,
it broke on 2.6.

The fact that it worked it all on 2.4 was a fluke.

It's time to breakdown, do the right thing and figure out how to rewrite/translate the
C++ code to C.

