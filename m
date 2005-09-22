Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVIVVz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVIVVz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVIVVz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:55:56 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:24059 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751283AbVIVVz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:55:56 -0400
Message-ID: <43332854.1070108@nortel.com>
Date: Thu, 22 Sep 2005 15:55:32 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: dipankar@in.ibm.com, Al Viro <viro@ftp.linux.org.uk>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20050922182719.GA4729@in.ibm.com> <4332FFF5.5060207@nortel.com> <20050922191805.GB4729@in.ibm.com> <43332400.2070606@nortel.com> <20050922214435.GA31911@kevlar.burdell.org>
In-Reply-To: <20050922214435.GA31911@kevlar.burdell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2005 21:55:46.0145 (UTC) FILETIME=[62C23D10:01C5BFC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:

> I think your loglevel is too low, set it to seven (using sysrq if
> necessary) and try again. 

I thought the following __handle_sysrq() code would take care of that:

	spin_lock_irqsave(&sysrq_key_table_lock, flags);
	orig_log_level = console_loglevel;
	console_loglevel = 7;
	printk(KERN_INFO "SysRq : ");

Chris
