Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265349AbUFBGMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265349AbUFBGMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUFBGMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:12:49 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:1221 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S265349AbUFBGMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:12:47 -0400
Message-ID: <40BD6FDE.6090006@candelatech.com>
Date: Tue, 01 Jun 2004 23:12:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Select/Poll
References: <MDEHLPKNGKAHNMBLJOLKAEJIMFAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEJIMFAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	Your issue has nothing to do with select or poll scalability, it has to do
> with the fact that UDP is unreliable and you must provide your own send
> timing. A UDP server or client cannot just send 100 messages in one shot and
> expect the other end to get all of them. They probably won't all even make
> it to the wire, so the recipient can't solve the problem.

You can check that they get to the wire in (almost?) all cases by watching
the return value for the sendto call.  And, if you have decent buffers on
the receive side, and a clean transport, then you can send at very high speeds
w/out dropping any significant number of packets, even when using select/poll and
non-blocking sockets...

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

