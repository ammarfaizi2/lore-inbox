Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCaSFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCaSFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVCaSFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:05:15 -0500
Received: from digitalimplant.org ([64.62.235.95]:29062 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261603AbVCaSFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:05:07 -0500
Date: Thu, 31 Mar 2005 10:04:55 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, "" <linux-kernel@vger.kernel.org>
Subject: Re: syslog loves the new driver core code
In-Reply-To: <20050331082814.GA26668@kroah.com>
Message-ID: <Pine.LNX.4.50.0503311004350.7249-100000@monsoon.he.net>
References: <20050331082814.GA26668@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Mar 2005, Greg KH wrote:

> Andrew pointed out to me that the new driver core code spewes a lot of
> stuff in the syslog for every device it tries to match up with a driver
> (if you look closely, it seems that the if check in __device_attach()
> will never not trigger...)
>
> Everything still seems to work properly, but it's good if we don't alarm
> people with messages that are incorrect and unneeded. :)
>
> So, here's a patch that seems to work for me.  It stops trying to loop
> through drivers or devices once it finds a match, and it only tells the
> syslog when we have a real error.
>
> Look acceptable to you?

Yes. Sorry about that.


	Pat
