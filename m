Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283405AbRK2VTE>; Thu, 29 Nov 2001 16:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283404AbRK2VSy>; Thu, 29 Nov 2001 16:18:54 -0500
Received: from ns.suse.de ([213.95.15.193]:8211 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S283393AbRK2VSm>;
	Thu, 29 Nov 2001 16:18:42 -0500
Date: Thu, 29 Nov 2001 22:18:41 +0100
From: Andi Kleen <ak@suse.de>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC: ethernet links should remember routes the same as addresses
Message-ID: <20011129221841.A14979@wotan.suse.de>
In-Reply-To: <3C068ED1.D5E2F536@nortelnetworks.com.suse.lists.linux.kernel> <p73r8qhqrmi.fsf@amdsim2.suse.de> <3C06A1C8.C133F725@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <3C06A1C8.C133F725@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Nov 29, 2001 at 03:59:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 03:59:52PM -0500, Christopher Friesen wrote:
> Unfortunately, this seems to only list the routes in the main routing table, and
> these routes are recreated automatically when I bring the link back up.

Well, it is not that hard to extend it. 

Just iterate over ip rule ls output too.

(left as an exercise for the reader) 

> If the driver re-init is totally separate from the routing code, is there any
> real reason why shutting down the driver *should* remove all routes to that
> device?  Maybe the simplest solution would be a new ioctl that would be a link
> *reset*...just down/up the link without affecting anything else....

If you just want to do a link reset you can use ethertool today with most
drivers. What is different is a full driver reset to work around software/
hardware bugs.  That would need to be a new ioctl.


-Andi
