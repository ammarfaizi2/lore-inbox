Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSJDA0Z>; Thu, 3 Oct 2002 20:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSJDA0Z>; Thu, 3 Oct 2002 20:26:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:25479 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261302AbSJDA0Y>;
	Thu, 3 Oct 2002 20:26:24 -0400
Subject: Re: export of sys_call_table
From: Andy Pfiffer <andyp@osdl.org>
To: Michal Jaegermann <michal@harddata.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20021003171013.B22986@mail.harddata.com>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk> 
	<20021003171013.B22986@mail.harddata.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Oct 2002 17:32:00 -0700
Message-Id: <1033691520.28254.6.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 16:10, Michal Jaegermann wrote:
> On Thu, Oct 03, 2002 at 11:02:40PM +0100, Alan Cox wrote:
> > On Thu, 2002-10-03 at 22:39, Brian F. G. Bidulock wrote:
> > 
> > > Until now, loadable modules have been able to just overwrite
> ...
> > 
> > Not actually safely implementable. The right way to do this is a
> > relevant 2.5 question.

> Hm, IIRC bproc stuff (Beowulf support) also relies on this ability.
> Or at least "kmonte" trick to load and switch to a new kernel.

The last kmonte that I worked with would preserve, then overwrite,
sys_call_table[__NT_reboot] with a pointer to it's version of reboot()
when the kmonte module was loaded.

If asked to unload, the original version of reboot() was restored prior
to being unloaded.

Andy

