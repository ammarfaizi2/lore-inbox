Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVDGBL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVDGBL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbVDGBL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:11:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:54408 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262367AbVDGBLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:11:47 -0400
Message-ID: <425488BB.9030004@nortel.com>
Date: Wed, 06 Apr 2005 19:11:23 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@osdl.org>, Alan Modra <amodra@bigpond.net.au>,
       Marty Ridgeway <mridge@us.ibm.com>, linux-kernel@vger.kernel.org,
       ltp-list@lists.sourceforge.net, ltp-announce@lists.sourceforge.net
Subject: Re: [ANNOUNCE] April Release of LTP now Available
References: <OF98479217.2360E20E-ON85256FDA.00696BC9-86256FDA.00698E70@us.ibm.com>	<20050406043001.3f3d7c1c.akpm@osdl.org> <16980.33841.943558.94159@cargo.ozlabs.ibm.com>
In-Reply-To: <16980.33841.943558.94159@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

> 	if (__sc_err & 0x10000000)					\
> 	{								\
> 		errno = __sc_ret;					\
> 		__sc_ret = -1;						\
> 	}								\


If you're messing with that code anyways, any chance of changing the 
assignment to "__sc_ret = -1UL;", since __sc_ret is of type unsigned long?

Chris
