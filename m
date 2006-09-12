Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWILCrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWILCrn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 22:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWILCrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 22:47:43 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:65471 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965143AbWILCrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 22:47:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GgjqcM4KdRS15aT9CvgUuqhJzkgkXNJrjue2dz98CwRSrA1b/f+8fNlG5ng9KH6/viMTCagGktcUud03Bctm01A9LxeZaUDXaXcr9pSNyTlMzAVGj/x9edpdRhWC7hDnK2jrr+8+US2g7pIlkeKFTdx8u0p6J5rE84Vgnb9mmX0=  ;
Message-ID: <45061FCB.1000402@yahoo.com.au>
Date: Tue, 12 Sep 2006 12:47:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Guennadi Liakhovetski <gl@dsa-ac.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17.4] slabinfo.buffer_head increases
References: <Pine.LNX.4.63.0607101023450.27628@pcgl.dsa-ac.de> <Pine.LNX.4.63.0607101412250.27628@pcgl.dsa-ac.de> <Pine.LNX.4.63.0609061341150.1700@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0609061341150.1700@pcgl.dsa-ac.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi Liakhovetski wrote:

>> On Mon, 10 Jul 2006, Guennadi Liakhovetski wrote:
>>
>>> I am obsering a steadily increasing buffer_head value in slabinfo under
>>> 2.6.17.4. I searched the net / archives and didn't find anything
>>> directly relevant. Does anyone have an idea or how shall we debug it?
>>
>
> The problem is still there under 2.6.18-rc2. I narrowed it down to 
> ext3 journal. To reproduce one just has to mount an ext3 partition and 
> perform (write) accesses to it. A loop { touch /mnt/foo; sleep 1; } 
> suffices - just let it run for a couple of minutes and monitor 
> buffer_head in /proc/slabinfo. If you mount it as ext2 the problem is 
> gone.


What data mode is ext3 mounted with?

Is the memory reclaimable? If yes, is it a problem?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
