Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWBWUf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWBWUf3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWBWUf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:35:29 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:39853 "EHLO rs27.luxsci.com")
	by vger.kernel.org with ESMTP id S1750938AbWBWUf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:35:28 -0500
Message-ID: <43FE1CAD.3050806@eventmonitor.com>
Date: Thu, 23 Feb 2006 15:35:57 -0500
From: Bryan Fink <bfink@eventmonitor.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS Still broken in 2.6.x?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
at least Trond thought, mid-January, that "The readahead algorithm has
been broken in 2.6.x for at least the past 6 months." (
http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
know if that has been fixed?

Basically, the problem I'm having is that downloads from an NFS server
using kernel 2.6 are no more than half as fast as the same from a
server using kernel 2.4.  Write speed (uploading) seems to be about the
same, but reading is slow.

I'm using tcp as my protocol, at the suggestion of many posts, but
flipping over to udp doesn't seem to make any difference.  I'm using
version 3, although I did switch to 2 just to check (it's no better,
usually slower).  My read size is 32768 and my write size is 8192.
Decreasing the read size only slows down the transfers.  Increasing
write size has no effect.

As for hardware, both machines are dual AMD Opterons, 100Mbps ethernet,
and the NFS is serving space on a RAID array.  The 2.4 (2.4.21 to be
exact) kernel is running under SuSE 9.0, and the 2.6 (2.6.15 to be
exact) kernel is running under SuSE 10.0.  I saw the same speed drop
when attempting to upgrade to SuSE 9.3.  I stayed with 9.0 in hopes
that the problem would be fixed in the future.

Anyone have any ideas?

-Bryan


