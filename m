Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933881AbWK3KIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933881AbWK3KIg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 05:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933934AbWK3KIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 05:08:36 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:49026 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S933892AbWK3KIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 05:08:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SWHwE6Zzj0CT57vrrhKUs7yS3CrjTY4H+stjaskKHLEcJkWvdTPyF6vgnVOlXJvh47lpYFTelnTsauCjYQKyDL30FCnJDa3UGH4zwdqLUfHLmwu6e0OC1DxDvAQZWgAUpQwWP7zy8r4dVNBzi5dkPfVYkP/ypTbP2MxINJdx/Ng=  ;
X-YMail-OSG: loKOseAVM1n9lHPqtY1UOEKE8eNU0Vh_mdmYVrzET.PoGLgcLg5yrkA9S6Cs1LSg3Gv38wr8cpvjmiuw6t1Ev_47gno6.GASE2VxbxeHGZAh4HaZRS6LjLeDhsiQSzT5pCppIxSVBRXCspA-
Message-ID: <456EAD6E.6040709@yahoo.com.au>
Date: Thu, 30 Nov 2006 21:07:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>,
       wenji@fnal.gov, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
References: <20061130061758.GA2003@elte.hu> <20061129.223055.05159325.davem@davemloft.net> <20061130064758.GD2003@elte.hu> <20061129.231258.65649383.davem@davemloft.net> <20061130073504.GA19437@elte.hu> <20061130095232.GA8990@2ka.mipt.ru>
In-Reply-To: <20061130095232.GA8990@2ka.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Thu, Nov 30, 2006 at 08:35:04AM +0100, Ingo Molnar (mingo@elte.hu) wrote:

> Doesn't the provided solution is just a in-kernel variant of the
> SCHED_FIFO set from userspace? Why kernel should be able to mark some
> users as having higher priority?
> What if workload of the system is targeted to not the maximum TCP
> performance, but maximum other-task performance, which will be broken
> with provided patch.

David's line of thinking for a solution sounds better to me. This patch
does not prevent the process from being preempted (for potentially a long
time), by any means.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
