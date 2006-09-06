Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWIFRVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWIFRVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWIFRVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 13:21:54 -0400
Received: from smtpout.mac.com ([17.250.248.186]:767 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751762AbWIFRVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 13:21:53 -0400
In-Reply-To: <44FE0BDE.40309@tmr.com>
References: <44FB5AAD.7020307@perkel.com> <44FBD08A.1080600@tls.msk.ru> <44FE0BDE.40309@tmr.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9A810B9-2FA1-4BEB-AA16-5EB16A0839A3@mac.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Raid 0 Swap?
Date: Wed, 6 Sep 2006 13:21:33 -0400
To: Bill Davidsen <davidsen@tmr.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 05, 2006, at 19:44:30, Bill Davidsen wrote:
> Final note: if you are building a really reliable system, RAID6 on  
> all data, redundant power supplies (the highest point of total  
> failure), then you should go to RAID0 for swap, on multiple  
> controllers, preferably one drives in different enclosures. RAID6  
> for swap sucks rocks off the bottom of the ocean, three way RAID1  
> performs well even after a one drive failure.

There's also some interesting high-performance FPGA-based products  
out there which stack another layer or two of reed-solomon coding on  
top of a group of N existing drives so that you can handle up to M  
drive failures where M < N, and optionally also a failure of a stripe  
of up to K sectors out of every group of J sectors.  IIRC your  
average CD and DVD uses this kind of encoding, so if you have a bunch  
of scattered errors or a single big error up to like 9k long you can  
still recover all the data while decoding.  Those kind of matrix  
transformations would be dog-slow on a general purpose CPU, but with  
custom FPGA or VLSI chips you can do it in parallel easily better  
than disk bandwidth

Cheers,
Kyle Moffett
