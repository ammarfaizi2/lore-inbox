Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTDMR4e (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 13:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTDMR4e (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 13:56:34 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:36316 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S261320AbTDMR4d (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 13:56:33 -0400
Date: Sun, 13 Apr 2003 14:03:41 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Benefits from computing physical IDE disk geometry?
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304131407_MC3-1-3441-57C7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:


>>
>> Any good SCSI drive knows the physical geometry of the disk and can
>> therefore optimally schedule reads and writes.  Although necessary features,
>> like read queueing, are also available in the current SATA spec, I'm not
>> sure most drives will implement it, at least not very well.
>>
> The "continuous" nature of drive addressing means that the kernel
> can do a fine job seek-wise. Due to write caches and read track
> buffers, rotational scheduling (which could be done if we knew
> geometry) would provide too little gain for the complexity. I would
> say that for most workloads you wouldn't see any difference. (IMO)


  OTOH you can come up with scenarios like, say, a DBMS doing 16K page
aligned IO to raw devices where you might see big gains from making sure
those 16K chunks didn't cross a physical cylinder boundary.


--
 Chuck
