Return-Path: <linux-kernel-owner+w=401wt.eu-S1030235AbXAKJJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbXAKJJz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbXAKJJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:09:55 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:22341 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030235AbXAKJJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:09:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZPIjdKUyF+1C3n/VZD5rpM6VD02tSVt1qBIjMP6gdfsbgzztELQHoTKYhw0Vf4FdsWDiq4KP9f7zj9rnBcPCdX0HTqVAX/TAXFA14oLaEfRl15lrU7QpHp7qlGI+bI2Vp1x9oDR4/Tcw7UyqTXcrtTufxK4CIat6recN5oy+wXk=  ;
X-YMail-OSG: q2u0VBUVM1kYmffI8t73KLJt9oIIKlV6H2LDYWyeoGS2p4UPVrnZ0XDsNL8sdy63KF1s8vvA4jxTDr6dU96jKWf3KtaoK4fROIoM25Q.q.Oh3hbI.t7.72vxHSvyril09uC43ZJ7gRgIKmnjQc_D.KWgkTmsKpNqOWn.bz_gABeT8sSV_enqh1kGwfqlfgirH9DjJuAx6SVUbOY-
Message-ID: <45A5FEC4.8020800@yahoo.com.au>
Date: Thu, 11 Jan 2007 20:09:24 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Huang <royhuang9@gmail.com>
CC: Aubrey <aubreylee@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>	 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>	 <20070110220603.f3685385.akpm@osdl.org>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au>	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>	 <45A5F157.9030001@yahoo.com.au> <afe668f90701110049m412a041awc1fd9a03660bec45@mail.gmail.com>
In-Reply-To: <afe668f90701110049m412a041awc1fd9a03660bec45@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Huang wrote:
> There is already an EMBEDDED option in config, so I think linux is
> also supporting embedded system. There are many developers working on
> embedded system runing linux. They also hope to contribute to linux,
> then other embeded developers can share it.

Yes, but we don't like to apply kernel hacks regardless if they "help"
embedded, desktop, server or anyone else.

Note that these tricks to limit file cache will only paper over the
actual issue, which is that large allocations must be contiguous and
thus subject to fragmentation on nommu kernels. The real solution to
this is simply not a kernel based one.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
