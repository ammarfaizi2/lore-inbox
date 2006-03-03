Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWCCR6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWCCR6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbWCCR6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:58:20 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:60240 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1161000AbWCCR6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:58:20 -0500
Message-ID: <44088360.2030705@cfl.rr.com>
Date: Fri, 03 Mar 2006 12:56:48 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jim Dennis <jimd@starshine.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: SEEK_HOLE and SEEK_DATA support?
References: <20060303170417.GA26909@starshine.org>
In-Reply-To: <20060303170417.GA26909@starshine.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2006 18:00:19.0987 (UTC) FILETIME=[55D51630:01C63EEC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14301.000
X-TM-AS-Result: No--16.250000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aren't there already apis to query for the holes in the file, and 
doesn't tar already use them to efficiently back up sparse files?  I 
seem to remember seeing that somewhere.

Jim Dennis wrote:
> 
>  Perhaps I should have been a bit more clear.  /var/log/lastlog has
>  been a sparse file in most implementation for ... well ... forever.
> 
>  The example issue is that the support for large UIDs and the convention
>  of setting nfsnobody to -1 (4294967294) combine to create a file whose
>  size is very large.  The du of the file is (in my case) only about
>  100KiB.  So there's a small cluster of used blocks for the valid
>  corporate UIDs that have ever accessed this machine ... then a huge
>  allocate hole, and then one block storing the lastlog timestamp for
>  nfsnobody.
> 
>  However, this message was not intended to dwell on the cause of that
>  huge sparse file ... but rather to inquire as to the core issue; 
>  how do we efficiently handle skipping over (potentially huge)
>  allocation holes in a portable fashion that might be adopted by
>  archiving and other tools?  I provided this example simply to point
>  out that it does happen, in the real world and has a significant
>  cost (40 minutes to scan through NULs with which the filesystem fills
>  the hole for read()s).
> 
>  OpenSolaris has implemented a mechanism for doing this and it sounds
>  reasonable from my admittedly superficial perspective.
> 

