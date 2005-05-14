Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbVENBBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbVENBBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 21:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVENBBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 21:01:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:4761 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262646AbVENBBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 21:01:31 -0400
Message-ID: <42854DE7.5030704@us.ibm.com>
Date: Fri, 13 May 2005 18:01:27 -0700
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Clay Haapala <chaapala@cisco.com>, lksctp-developers@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: SCTP: use lib/libcrc32c.c instead of net/sctp/crc32c.c?
References: <20050513135004.GG3603@stusta.de>
In-Reply-To: <20050513135004.GG3603@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>As far as I understand it, lib/libcrc32c.c could be used instead of the 
>similar code in net/sctp/crc32c.c .
>
>Is there any reason why this isn't done?
>  
>
The SCTP RFC3309 says that SCTP uses a tranport-level CRC where the bit
ordering is mirrored and different from link-level CRC.

The CRC is computed using a procedure similar to ETHERNET CRC [ITU32],
modified to reflect transport level usage.

So I am not sure if we can use the libcrc32c routines for calculating SCTP
crc32 checksum. But if it is possible, we should definitely use the crc32
library.

Thanks
Sridhar






