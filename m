Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVIFPYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVIFPYo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVIFPYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 11:24:44 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:49869 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750715AbVIFPYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 11:24:44 -0400
Message-ID: <431DB4B4.6040907@nortel.com>
Date: Tue, 06 Sep 2005 09:24:36 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: looking for help tracing oops -- resolved
References: <431925C4.60509@nortel.com>
In-Reply-To: <431925C4.60509@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Sep 2005 15:24:36.0588 (UTC) FILETIME=[17340AC0:01C5B2F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the tips, guys.

I managed to get the problem to occur on a vanilla kernel with just the 
proprietary module loaded.  Contacted the vendor, they got me to try out 
a new driver, problem appears to be fixed.

Looks like the module wasn't properly tracking refcounts, so it was 
being unloaded when there were still dangling references.  Oops.

Thanks,

Chris
