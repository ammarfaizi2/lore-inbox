Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVKUTqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVKUTqm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 14:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVKUTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 14:46:42 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:41097 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932410AbVKUTql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 14:46:41 -0500
Message-ID: <4382240D.4000507@nortel.com>
Date: Mon, 21 Nov 2005 13:46:21 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
References: <438220C3.4040602@nortel.com>
In-Reply-To: <438220C3.4040602@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Nov 2005 19:46:23.0557 (UTC) FILETIME=[40AE4F50:01C5EED4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:
> 
> When using netlink, should "nlmsg_pid" be set to pid (current->tgid) or 
> tid (current->pid)?

The reason I ask is that with 2.6.10 we had to set it to tid, which 
really doesn't make much sense given than sockets are shared across all 
threads in a process (and gettid() isn't even a libc function).

Chris
