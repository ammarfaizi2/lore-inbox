Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265088AbUE0Td3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265088AbUE0Td3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 15:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUE0Td3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 15:33:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29668 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265088AbUE0TbN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 15:31:13 -0400
Message-ID: <40B641F4.1040806@pobox.com>
Date: Thu, 27 May 2004 15:31:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, prism54-devel@prism54.org
Subject: Re: [Prism54-devel] Re: [PATCH 4/14 linux-2.6.7-rc1] prism54: add
 support for avs header in
References: <20040524083146.GE3330@ruslug.rutgers.edu> <40B631B3.4000902@pobox.com> <20040527191649.GT3330@ruslug.rutgers.edu>
In-Reply-To: <20040527191649.GT3330@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> On Thu, May 27, 2004 at 02:21:39PM -0400, Jeff Garzik wrote:
> 
>>Luis R. Rodriguez wrote:
>>
>>>diff -u -r1.31 -r1.33
>>>--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 2004 
>>>15:27:44 -0000	1.31
>>>+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	19 Mar 2004 
>>>23:03:58 -0000	1.33
>>>@@ -1,4 +1,4 @@
>>>-/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.31 2004/03/18 
>>>15:27:44 ajfa Exp $
>>>+/*  $Header: /var/lib/cvs/prism54-ng/ksrc/islpci_eth.c,v 1.33 2004/03/19 
>>>23:03:58 ajfa Exp $
>>
>>
>>Please remove CVS substitions from your code, they cause endless patch 
>>rejects if I choose to apply (for example) 10 out of 14 patches.
> 
> 
> Will do. So if you get 
> 
> --- ksrc/islpci_eth.c
> +++ ksrc-new/islpci_eth.c
> 
> patches, that'll be OK? I substituted ksrc to
> linux-2.6.7-rc1/drivers/net/wireless/prism54 thinking that'll ease your
> job. Sorry for any inconvenience.


I think you misunderstand (and I apologize for causing the confusion).

It is _required_ that the patches include the full path in the header. 
You did this correctly:
--- linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	18 Mar 
2004 15:27:44 -0000	1.31
+++ linux-2.6.7-rc1/drivers/net/wireless/prism54/islpci_eth.c	19 Mar 2004


I am referring to the CVS substitution variables embedded in your source 
code.  In this case $Header$.

However, consider what happens when I do:

1) apply patch #1
2) reject patch #2
3) attempt to apply patch #3

If each patch updates the $Header$, then patch #3 cannot be applied 
because patch(1) will reject it due to the now-incorrect $Header$ line.

The $Header$ _forces_ me to apply your patches in order, all or none.  I 
don't think you want that ;-)

	Jeff


