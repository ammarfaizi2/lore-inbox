Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263836AbUCZAIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUCZAID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:08:03 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:37130 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263836AbUCZAAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:00:10 -0500
Date: Thu, 25 Mar 2004 23:59:21 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@osdl.org>
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <1739144.1080259161@[192.168.0.89]>
In-Reply-To: <20040325155117.60dbc0e1.akpm@osdl.org>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
 	<20040325130433.0a61d7ef.akpm@osdl.org>
 	<41997489.1080257240@42.150.104.212.access.eclipse.net.uk>
 <20040325155117.60dbc0e1.akpm@osdl.org>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On 25 March 2004 15:51 -0800 Andrew Morton <akpm@osdl.org> wrote:

> I think it's simply:
>
> - Make normal overcommit logic skip hugepages completely
>
> - Teach the overcommit_memory=2 logic that hugepages are basically
>   "pinned", so subtract them from the arithmetic.
>
> And that's it.  The hugepages are semantically quite different from normal
> memory (prefaulted, preallocated, unswappable) and we've deliberately
> avoided pretending otherwise.

True currently.  Though the thread that prompted this was in response to 
the time taken for this prefault and for the wish to fault them.

I'll have a poke about at it and see how small I can make it.

-apw
