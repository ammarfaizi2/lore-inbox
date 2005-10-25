Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVJYGYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVJYGYO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 02:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVJYGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 02:24:14 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:33958 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751423AbVJYGYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 02:24:13 -0400
Subject: Re: select() for delay.
From: "Madhu K.S." <madhu.subbaiah@wipro.com>
Reply-To: madhu.subbaiah@wipro.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1130160451.2775.8.camel@laptopd505.fenrus.org>
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
	 <1130159934.7804.15.camel@localhost.localdomain>
	 <1130160451.2775.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Wipro technologies
Message-Id: <1130221601.7416.6.camel@penguin.madhu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 25 Oct 2005 11:56:41 +0530
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2005 06:23:54.0540 (UTC) FILETIME=[AC7A1EC0:01C5D92C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Someone please comment on the entire patch functionality. 
I tested this patch, it seems to work fine.

Kindly suggest.



On Mon, 2005-10-24 at 18:57, Arjan van de Ven wrote:
> On Mon, 2005-10-24 at 09:18 -0400, Steven Rostedt wrote:
> > Hi Maduhu,
> > 
> > On Mon, 2005-10-24 at 16:25 +0530, madhu.subbaiah@wipro.com wrote:
> > 
> > > +                        put_user(sec, &tvp->tv_sec);
> > > +                        put_user(usec, &tvp->tv_usec);
> > 
> > I won't comment on the rest of the patch, but this part is definitely
> > wrong.  The pointer tvp is a user space address and once you dereference
> > that pointer to get to tv_sec, you can have a fault, which might
> > segfault the
> 
> &pointer->member  doesn't dereference the pointer, it just adds the
> offset of "member" to the content of the pointer.
> 
> 

