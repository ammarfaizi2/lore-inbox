Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVKBCsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVKBCsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbVKBCsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:48:50 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:64131 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932234AbVKBCst (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 1 Nov 2005 21:48:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=wlM4/TvL2DRPpGbu+/1+i9Xo2JE14wvN5ZveJXeX4eqYAjdchtel6qhXkKx4eDA0kgiWjlhvb16cF5XZMw1P1mqJGcNgOMk4CFKBovM3rjbye9u6/OX29BSG2Dg9Cgd8LdGT5pdwFqCxV8+6YoqFVL8jqJTgY8P2FH0Aloq7xOI=  ;
Message-ID: <43682878.3040800@yahoo.com.au>
Date: Wed, 02 Nov 2005 13:46:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Li, Shaohua" <shaohua.li@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Nigel Cunningham <ncunningham@cyclades.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Ian Molton <spyro@f2s.com>
Subject: Re: [PATCH 2.6.14-rc1-git5] sched: disable preempt in idle tasks
References: <59D45D057E9702469E5775CBB56411F1C19A01@pdsmsx406>
In-Reply-To: <59D45D057E9702469E5775CBB56411F1C19A01@pdsmsx406>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Shaohua,

Li, Shaohua wrote:

> 
> What's the status of the patch? I didn't see it in base kernel.
> We found another bug related with this issue. On UP system, if a CPU
> enters 
> 'mwait_idle', it never leaves it, as the 'mwait_idle' loop will never
> end.
> Disabling preempt fixes the bug. Should I submit a patch just disabling
> preempt in 'mwait_idle' or wait for your patch?
> 

The patch is in Andrew's tree, and it should get merged for 2.6.15.
If you have verified that disabling preempt in mwait_idle fixes the
bug, then you may like to send that to the 2.6.14.stable guys.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
