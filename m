Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWFRFGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWFRFGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 01:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWFRFGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 01:06:31 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:3696 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932092AbWFRFGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 01:06:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=51eg05bVSVDiyTbEqx+r09/mNdO4AViDGBNRQUQEmZGAo5Ke9FRkQizWoyvIzQRl2RBEMDaqbVFtDKJMZtqJvSRw6sDBg+0BZNFyQMl990gUA0atstc22m+NE/tzFULDhjzNQ45gJX6y+tBVheDm2esINEh8bEb/eXTtGFEEFB0=  ;
Message-ID: <4494DF50.2070509@yahoo.com.au>
Date: Sun, 18 Jun 2006 15:06:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org, maeda.naoaki@jp.fujitsu.com,
       kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com> <4493C1D1.4020801@yahoo.com.au> <20060617164812.GB4643@in.ibm.com>
In-Reply-To: <20060617164812.GB4643@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sat, Jun 17, 2006 at 06:48:17PM +1000, Nick Piggin wrote:
> 
>>Srivatsa Vaddagiri wrote:
>>
>>>	- Do we need mechanisms to control CPU usage of tasks, further to 
>>>	what
>>>	  already exists (like nice)?  IMO yes.
>>
>>Can we get back to the question of need? And from there, work out what
>>features are wanted.
>>
>>IMHO, having containers try to virtualise all resources (memory, pagecache,
>>slab cache, CPU, disk/network IO...) seems insane: we may just as well use
>>virtualisation.
>>
>>So, from my POV, I would like to be convinced of the need for this first.
>>I would really love to be able to keep core kernel simple and fast even if
>>it means edge cases might need to use a slightly different solution.
> 
> 
> I think a proportional-share scheduler (which is what a CPU controller
> may provide) has non-container uses also. Do you think nice (or sched policy) 
> is enough to, say, provide guaranteed CPU usage for applications or limit 
> their CPU usage? Moreover it is more flexible if guarantee/limit can be 
> specified for a group of tasks, rather than individual tasks even in
> non-container scenarios (like limiting CPU usage of all web-server 
> tasks togther or for limiting CPU usage of make -j command).
> 

Oh, I'm sure there are lots of things we *could* do that we currently can't.

What I want to establish first is: what exact functionality is required, why,
and by whom. Only then can we sanely discuss the fitness of solutions and
propose alternatives, and decide whether to merge.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
