Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422978AbWJFV2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWJFV2X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422980AbWJFV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:28:23 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:46473 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422978AbWJFV2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:28:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=OsM94SZB3zISLvbKOfn3yaH3WfECFGqcq8SqD5sx56IGOxl4wohHbuQJYxgKU6hgwxxae1D9AMvXaZEptoJvWV6fuBUb4k78uWla82aYBVS/BFolyf/c2IsyvNRXqQFxPuLVls94TDYNtdptm4zijcS6DTqsjxTVIPHIw30oUMs=  ;
From: David Brownell <david-b@pacbell.net>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Fri, 6 Oct 2006 14:10:09 -0700
User-Agent: KMail/1.7.1
Cc: linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
References: <Pine.LNX.4.44L0.0610051631550.7144-100000@iolanthe.rowland.org> <200610051947.44595.david-b@pacbell.net> <200610060904.51936.oliver@neukum.org>
In-Reply-To: <200610060904.51936.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610061410.10059.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 12:04 am, Oliver Neukum wrote:
> Am Freitag, 6. Oktober 2006 04:47 schrieb David Brownell:
> > On Thursday 05 October 2006 2:25 pm, Oliver Neukum wrote:
> > 
> > > - the issues of manual & automatic suspend and remote wakeup are orthogonal
> > > - there should be a common API for all devices
> > 
> > AFAIK there is no demonstrated need for an API to suspend
> > individual devices.  ...
> 
> I doubt that a lot. 

You haven't demonstrated such a need either; so why doubt it?


> Eg. Again, if I close the lid I may want my USB 
> network cards be suspended 

If "close lid" means system suspend, then you _do_ want that
(by definition of system suspend).  If that doesn't trigger
system suspend, then it's up to you to decide whether or not
you "ifdown eth1" or not ... as with non-USB network adapters.

Likewise with autosuspending of network devices, which I'd
actually like to see happen.  Starting in 2.6.19-rc, the USB
drivers could be updated to do that, as I understand ... at
least for hardware that has sane remote wakeup capabilities.
No point in having host controllers doing nothing except
polling a USB network adapter, unless there's actually some
traffic directed to that host!


> or not and that decision might change several 
> times a day. It's a policy decision in many cases. And I'd not be happy
> with being required to down the interfaces to do so.

Lots of us would be even more unhappy to see USB network adapters
be made to follow different rules than non-USB ones.

