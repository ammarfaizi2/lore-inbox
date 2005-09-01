Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVIAU42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVIAU42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVIAU42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:56:28 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14217 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030345AbVIAU41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:56:27 -0400
Message-ID: <43176AE8.8060105@austin.ibm.com>
Date: Thu, 01 Sep 2005 15:56:08 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]> <20050901145006.GF5427@devserv.devel.redhat.com>
In-Reply-To: <20050901145006.GF5427@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>                /* If flip is full, just reschedule a later read */
>>                if (count == 0) {
>>                        poll_mask |= HVC_POLL_READ;
>>
>>shouldn't be deleting the declaration of count. 
>>and possibly the "flip removal" was incomplete (line 636) ???
> 
> 
> Yep. You can remove the tty->flip.count test or use count, but at that
> point count is guaranteed to be > 0 I believe. Fixed both in my tree will
> push a new diff to Andre soon.

There are at least a couple other spots where flip got missed, after 
fixing the count and flip problem mentioned these come up:

drivers/char/hvcs.c:459: error: structure has no member named `flip'
drivers/char/hvcs.c:472: error: structure has no member named `flip'


