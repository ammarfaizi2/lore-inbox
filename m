Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUBSXgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUBSXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:36:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267441AbUBSXga
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:36:30 -0500
Message-ID: <40354871.1060009@pobox.com>
Date: Thu, 19 Feb 2004 18:36:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: MALET JL <malet.jean-luc@laposte.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [drivers][sata-promise] TX4 has the cache enabled, it should
 be disabled
References: <4031DB3E.8000406@laposte.net>
In-Reply-To: <4031DB3E.8000406@laposte.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MALET JL wrote:
> hello,
> I've a TX4 150 card and encounter the following effects :
> ->"shorts" files (<1Mo) are copied at 35Mo/s av
> ->"long" files (>1Mo) are "burst" copied (ie a big "burst" then hangs, 
> burst, hangs) this has the following effects :
> 1) average fall back to 12Mo/s
> 2) systems "hangs" (mouse, keyboard behave like a 100% used cpu) but cpu 
> usage is still slow
> 3) mplayer reset the streams every second (cpu usage still low)
> 
> this is 1-2 week that I have this issue, but can't find where it comes 
> from...... yesterday by chance when I loaded sata-promise I noticed 
> "write through" this remembered be some issue I go when I first had the 
> sata board, making a short research made me remember :
> 
> DISABLE THE BOARD CACHE! on windows this is the same when cache is 
> enabled : performance drops, system interactive is awfull....


There is no on-board cache on the TX4.

Further, you are thinking about the SCSI layer's caching support, i.e. 
basically whether the driver supports SYNCHRONIZE CACHE (aka 
flush-cache) scsi command.

	Jeff



