Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbWASCVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWASCVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 21:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbWASCVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 21:21:36 -0500
Received: from ns2.lanforge.com ([66.165.47.211]:50915 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1030497AbWASCVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 21:21:36 -0500
Message-ID: <43CEF7A6.30802@candelatech.com>
Date: Wed, 18 Jan 2006 18:21:26 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can you specify a local IP or Interface to be used on a per	NFS
 mount basis?
References: <43CECB00.40405@candelatech.com> <1137631728.13076.1.camel@lade.trondhjem.org>
In-Reply-To: <1137631728.13076.1.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Wed, 2006-01-18 at 15:10 -0800, Ben Greear wrote:
> 
>>Hello!
>>
>>Is there any way to specify what local IP address an NFS
>>client uses to mount an NFS server?
>>
>>For instance, if I have eth0 with IP 192.168.1.6 and eth1
>>with IP 192.168.1.7, how can I make sure that a particular
>>mount point is accessed via 192.168.1.7?
> 
> 
> NFS doesn't know anything about ip packet routing. That is a networking
> issue.

When a socket is created, you can optionally bind to local IP, interface and/or
IP-Port.  Somewhere, NFS is opening a socket I assume?  So, is there a way to
ask it to bind?

You can then use this source-IP to convince the routing logic to use a
particular interface (ie, the interface with that IP on it).

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

