Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbTEMRuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTEMRuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:50:05 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:39207 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262498AbTEMRuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:50:04 -0400
Subject: Re: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com
In-Reply-To: <20030513173044.GB10284@kroah.com>
References: <Pine.LNX.4.44L0.0305131117240.3274-100000@ida.rowland.org>
	 <1052840106.2255.24.camel@diemos>  <20030513173044.GB10284@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052830860.1992.2.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 May 2003 08:01:01 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 12:30, Greg KH wrote:
> On Tue, May 13, 2003 at 10:35:07AM -0500, Paul Fulghum wrote:
> > On Tue, 2003-05-13 at 10:26, Alan Stern wrote:
> > 
> > > Putting in a sanity check for the global suspend state will be very easy.  
> > > But I would like to point out that this "global suspend" does not refer to
> > > the entire system, only the USB bus.
> > 
> > That is a problem then, because the delay can still
> > occur during normal system operation.
> 
> Ok, can you try the attached patch and see if it causes your latency
> problem to go away?

I applied the patch plus a couple of printk statements,
and the wakeup_hc() is being continuously called
as well as actually executing the delay.

So the check is not preventing anything.

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


