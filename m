Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVARAi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVARAi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVARAi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:38:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:56014 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261310AbVARAi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:38:56 -0500
Message-ID: <41EC5207.3030003@osdl.org>
Date: Mon, 17 Jan 2005 16:02:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
CC: Daniel Drake <dsd@gentoo.org>, Andrew Morton <akpm@osdl.org>,
       Joseph Fannin <jhf@rivenstone.net>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org> <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Tue, Jan 18, 2005 at 02:54:24AM +0000, Daniel Drake wrote:
> 
>>Retry up to 20 times if mounting the root device fails.  This fixes booting
>>from usb-storage devices, which no longer make their partitions immediately
>>available.
> 
> 
> Sigh...  So we can very well get device coming up in the middle of a loop
> and get the actual attempts to mount the sucker in wrong order.  How nice...
> 
> Folks, that's not a solution.  And kludges like that really have no
> business being there - they only hide the problem and make it harder
> to reproduce.

Is there a solution other than initrd/initramfs ?

Thanks,
-- 
~Randy
