Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWFBT5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWFBT5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWFBT5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:57:06 -0400
Received: from weber.sscnet.ucla.edu ([128.97.42.3]:10415 "EHLO
	weber.sscnet.ucla.edu") by vger.kernel.org with ESMTP
	id S1751466AbWFBT5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:57:04 -0400
Message-ID: <44809653.9010203@cogweb.net>
Date: Fri, 02 Jun 2006 12:49:39 -0700
From: David Liontooth <liontooth@cogweb.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060517)
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB devices fail unnecessarily on unpowered hubs
References: <Pine.LNX.4.44L0.0606021109390.7076-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0606021109390.7076-100000@iolanthe.rowland.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> Trying to draw too much current from an unpowered hub can and does cause 
> data loss.
>   
I consider this issue closed; thank you for looking at it. The
workaround is reasonably simple for the common situation of mounting a
USB stick on a keyboard, perhaps with a mouse attached in a second port:

NUM="$(dmesg | tail -n 3 | grep -r 'new full speed USB device' | cut -b
5-9)"
echo -n 1 >/sys/bus/usb/devices/$NUM/bConfigurationValue

with the understanding this breaks USB power rules and can lead to data
loss.

Dave
