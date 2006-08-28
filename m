Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWH1Mby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWH1Mby (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 08:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWH1Mby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 08:31:54 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:15226 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964839AbWH1Mbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 08:31:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=FPINSvbAJR/ITjasMKxmnRGYJiNHWF2pdhExZNfM2JasH8Wjch3QSJYtjOG9zB89HRO/ZsIN+wV4RyVPqKAjp993RHJHciy4huenvPgsO/tKEVP41/pJK1SDHcDvRVWVrAf29sMf/eXliFfJl4Hrmn8ukFjbcMX1DoS9vFoVHH4=  ;
Message-ID: <44F2E216.7090300@yahoo.com.au>
Date: Mon, 28 Aug 2006 22:31:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Kirill Korotaev <dev@sw.ru>, Ingo Molnar <mingo@elte.hu>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: Re: [PATCH 1/7] CPU controller V1 - split runqueue
References: <20060820174015.GA13917@in.ibm.com> <20060820174147.GB13917@in.ibm.com> <44EEEF28.4080707@sw.ru> <20060828033331.GA25119@in.ibm.com> <44F2A62C.9090609@sw.ru> <20060828110330.GA30090@in.ibm.com>
In-Reply-To: <20060828110330.GA30090@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Mon, Aug 28, 2006 at 12:15:40PM +0400, Kirill Korotaev wrote:
>>When I talked with Nick Piggin on summit he was quite optimistic
>>with such an approach. And again, this invasiveness is very simple
>>so I do not forsee much objections.
> 
> 
> Ingo/Nick, what do you think? If we decide that is a usefull thing to
> try, I can see how these mechanisms will be usefull for general SMP
> systems too (w/o depending on resource management).

I still haven't had much time to look at the implementation, but this
design seems cleanest I've considered, IMO.

Of course I would really hope we don't need any special casing in the
SMP balancing (which may be the tricky part). However hopefully if
things don't work well in that department, they can be made to by
improving the core code to be more general rather than special casing.

Do you have a better (/another) idea for the design?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
