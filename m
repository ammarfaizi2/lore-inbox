Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWFQItH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWFQItH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 04:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWFQItG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 04:49:06 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:16059 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751048AbWFQItF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 04:49:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kClAna2bHFl34402tMVUnByFbIYF7ttQp7K73AGGX+kecIha6sC42N32EtiCI5P3Y5Xw5UB8R+Sz7d1YUGD5x97g1RMZGYJWdq3g9fUXlJDfbn9XGf+YG9UYiC3u0NninhSUYUALXUzV5MrVw8aJbezxKAsB7mDsbp74eaJLFdg=  ;
Message-ID: <4493C1FB.802@yahoo.com.au>
Date: Sat, 17 Jun 2006 18:48:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: ak@suse.de, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special
 RT tasks.
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>	<p7364j1qx66.fsf@verdi.suse.de>	<20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>	<200606161236.50302.ak@suse.de>	<44937B16.3050204@yahoo.com.au>	<20060617141216.dba310af.kamezawa.hiroyu@jp.fujitsu.com>	<4493AF5C.4080600@yahoo.com.au> <20060617165319.458d913a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060617165319.458d913a.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> On Sat, 17 Jun 2006 17:29:32 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>>As SIGSTOP/KILL patch I posted, the apps shouldn't do unexpected
>>>work, I think.
>>
>>I don't quite understand you here... the kernel doesn't need to enforce
>>anything but a dumb fallback policy where userspace is otherwise capable
>>of handling it themselves.
> 
> 
> If all things about apps are properly maintained/managed, it is reconfigured
> by the user/system admin *before* cpu hotremove.
> 
> The case "the kernel have to move the task to other cpu which user doesn't want"
> means the application is already broken.
> 
> So, I think "stop mis-configurated process" can be one way for handling  such apps.
> 
> For example)
> After exchanging broken cpu, the application can continue its work with the
> same # of cpus.

OK I can see what you're trying to achieve, but I don't know that it is
worthwhile. Userspace is doing something wrong, and it isn't normally the
kernel's job to detect that.

When something like this comes up, sticking to the simplest semantics is
often best.

That said, it isn't a great deal of code to maintain, and not "incorrect"
as such. So if you convince Ingo to pick it up, I wouldn't complain.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
