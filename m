Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031760AbWLATii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031760AbWLATii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031762AbWLATii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:38:38 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:39828 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1031760AbWLATii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:38:38 -0500
Message-ID: <4570848C.5040705@freescale.com>
Date: Fri, 01 Dec 2006 13:37:48 -0600
From: Scott Wood <scottwood@freescale.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make platform_device_add_data accept a const pointer.
References: <20061201185447.GA19669@ld0162-tx32.am.freescale.net> <20061201193428.GA4055@flint.arm.linux.org.uk>
In-Reply-To: <20061201193428.GA4055@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Dec 01, 2006 at 12:54:47PM -0600, Scott Wood wrote:
> 
>>platform_device_add_data() makes a copy of the data that is given to it,
>>and thus the parameter can be const.  This removes a warning when data
>>from get_property() on powerpc is handed to platform_device_add_data(),
>>as get_property() returns a const pointer.
> 
> 
> Doesn't this cause a compile warning in platform.c, concerning assigning
> 'data' to struct device's non-const 'platform_data' pointer?

No, because it doesn't assign data to platform_data; it memcpy()s it (as 
stated above).

-Scott
