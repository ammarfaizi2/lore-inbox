Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWJESna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWJESna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWJESna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:43:30 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:33676 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750763AbWJESn3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:43:29 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] error to be returned while suspended
Date: Thu, 5 Oct 2006 20:43:59 +0200
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <Pine.LNX.4.44L0.0610051418540.6897-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0610051418540.6897-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610052044.00324.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Oktober 2006 20:24 schrieb Alan Stern:
> On Thu, 5 Oct 2006, Oliver Neukum wrote:
> 
> > Am Donnerstag, 5. Oktober 2006 18:21 schrieb Alan Stern:
> > > Currently we don't have any userspace APIs for such a daemon to use.  The 
> > > only existing API is deprecated and will go away soon.
> > 
> > I trust it'll be replaced.
> 
> Yes.  I think Greg wants to wait until the old API is completely gone.

I doubt it will. There's a potential need.

[..]
> > In the general case the idea seems insufficient. If I close my laptop's lid
> > I want all input devices suspended, whether the corresponding files are
> > opened or not. In fact, if I have port level power control I might even
> > want to cut power to them.
> 
> That's a separate issue.  You were talking about runtime suspend, but 
> closing the laptop's lid is a system suspend.

Why? If you freeze my batch jobs or make unavailable the servers
running on my laptop I'd be very unhappy.
But I want to make jostling a mouse or other input device safe. Thus
I want them to be suspended without autoresume. We need flexibility.

[..]
> P.S.: Cutting off port power is yet another issue.  It isn't a suspend in 
> the strict sense, because it will break an existing power session.

Yes, it is an additional more complicated option.

	Regards
		Oliver
