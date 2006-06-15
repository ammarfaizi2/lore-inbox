Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030949AbWFOSVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030949AbWFOSVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 14:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbWFOSVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 14:21:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:34434 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030949AbWFOSVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 14:21:22 -0400
Message-ID: <4491A398.4050204@in.ibm.com>
Date: Thu, 15 Jun 2006 23:44:48 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Chris Sturtivant <csturtiv@sgi.com>
Subject: Re: ON/OFF control of taskstats accounting data at do_exit
References: <449093D6.6000806@engr.sgi.com> <4490CDC2.3090009@watson.ibm.com> <4490D515.8070308@engr.sgi.com> <449182FB.6020907@watson.ibm.com> <449197D3.3090109@sgi.com>
In-Reply-To: <449197D3.3090109@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> For that reason, i think exposing the switch at sysfs is not a good
> idea. Instead, /etc/init.d/taskstats script would be right for
> this purpose. At kernel side, we would need to make this possible.

When you say we need to make this possible at the kernel side, do you
want the kernel not to accumulate taskstats in the do_exit() path
(avoid calling fill_xxxx routines) if there are no listeners
on TASKSTATS_LISTEN_GROUP? As Shailabh, mentioned sending out does not
happen if there are no listeners.

> 
> What do you think?
> 
> Regards,
>  - jay
> 
-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
