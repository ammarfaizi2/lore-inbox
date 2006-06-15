Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWFODCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWFODCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWFODCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:02:33 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:22398 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751302AbWFODCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:02:32 -0400
Date: Wed, 14 Jun 2006 23:02:26 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
In-reply-to: <449093D6.6000806@engr.sgi.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Balbir Singh <balbir@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Message-id: <4490CDC2.3090009@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <449093D6.6000806@engr.sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

>Hi Balbir and Shailabh,
>
>I propose we add the capability to turn ON/OFF the multicase of
>taskstats accounting data at do_exit().
>  
>

>This would allow 'chkconfig taskstats' like of control similar
>to 'chkconfig acct' for BSD accounting. Sometimes sysadmins would
>wish to turn off sending accounting data to the multicast socket.
>We have seen many situations that our CSA customers need to turn
>off CSA for a period of time.
>
 

What happens to other clients listening to the data ? This sort of 
configuration option would
again be along the lines of a systemwide change prompted by needs of one 
subsystem but affecting
all others - something Andrew had recommended against doing while we 
were discussing the per-tgid
turnoff.

The existing way to solve this is for the listeners to close the socket 
and reopen again later when they
are interested.  If there are no listeners at all, data won't be sent by 
the kernel anyway. Won't that work
for you ?

--Shailabh

>I think this feature is very important to this new interface.
>
>Thanks,
> - jay
>  
>


