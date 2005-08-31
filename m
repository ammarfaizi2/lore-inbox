Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVHaVU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVHaVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 17:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVHaVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 17:20:29 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:18865 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S964967AbVHaVU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 17:20:28 -0400
Message-ID: <43161F03.5090604@nortel.com>
Date: Wed, 31 Aug 2005 15:20:03 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: akpm@osdl.org, joe.korty@ccur.com, george@mvista.com, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
References: <F989B1573A3A644BAB3920FBECA4D25A042B0053@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A042B0053@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Aug 2005 21:20:06.0402 (UTC) FILETIME=[C248DE20:01C5AE71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
> In this structure,
> the user specifies:
>     whether the time is absolute, or relative to 'now'.


> Timeout_sleep has a return argument, endtime, which is also in
> 'struct timeout' format.  If the input time was relative, then
> it is converted to absolute and returned through this argument.

Wouldn't it make more sense for the endtime to be returned in the same 
format (relative/absolute) as the original timer was specified?  That 
way an application can set a new timer for "timeout + SLEEPTIME" and on 
average it will be reasonably accurate.

In the proposed method, for endtime to be useful the app needs to check 
the current time, compare with the endtime, and figure out the delta. 
If you're going to force the app to do all that work anyway, the app may 
as well use absolute times.

Chris
