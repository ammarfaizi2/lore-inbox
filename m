Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWFALma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWFALma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWFALma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 07:42:30 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:36605 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750844AbWFALma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 07:42:30 -0400
Message-ID: <447ED2A4.4030202@gentoo.org>
Date: Thu, 01 Jun 2006 12:42:28 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB devices fail unnecessarily on unpowered hubs
References: <447EB0DC.4040203@cogweb.net> <20060601030140.172239b0.akpm@osdl.org>
In-Reply-To: <20060601030140.172239b0.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> (added linux-usb cc)
> 
> Yes, it sounds like we're being non-real-worldly here.  This change
> apparently broke things.  Did it actually fix anything as well?

Gentoo recieved several reports of this. It appears that certain vendors 
are worse than others (Verbatim flash drives are a common culprit).

Some users tested and found that Windows has the same behaviour - it 
rejects these devices on unpowered hubs, and pops up a warning that not 
enough power is available.

I added a printk to point out when configurations are rejected due to 
power issues, this has been merged into Greg's tree. It's far from 
ideal, but better than silent failure...

Daniel
