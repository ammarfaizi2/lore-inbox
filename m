Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWFRH2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWFRH2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWFRH2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:28:38 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:58286 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932113AbWFRH2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:28:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VeWinVzy38/kQCRHrWzuIACou6EY9lXm2yHQEmre210s4+H+WXGg85t1AsLce8K2bNrpve0D2B1xbyjdDS9Mlh3m+6FfLHFOfRG6Ei9nvPuFoonWmBsJrGpS7lncbDZo7gud7eOeafA6Z+lB6cRq2/zw97ZSYwgpFckQ9OnppdE=  ;
Message-ID: <4495009D.9030505@yahoo.com.au>
Date: Sun, 18 Jun 2006 17:28:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sam@vilain.net, vatsa@in.ibm.com, dev@openvz.org, efault@gmx.de,
       mingo@elte.hu, pwil3058@bigpond.net.au, sekharan@us.ibm.com,
       balbir@in.ibm.com, linux-kernel@vger.kernel.org,
       maeda.naoaki@jp.fujitsu.com, kurosawa@valinux.co.jp
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com>	<4493C1D1.4020801@yahoo.com.au>	<20060617164812.GB4643@in.ibm.com>	<4494DF50.2070509@yahoo.com.au>	<4494EA66.8030305@vilain.net>	<4494EE86.7090209@yahoo.com.au> <20060617234259.dc34a20c.akpm@osdl.org>
In-Reply-To: <20060617234259.dc34a20c.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sun, 18 Jun 2006 16:11:18 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>If you want to *completely* isolate N groups of users, surely you
>>have to use virtualisation,
> 
> 
> I'd view this as a kludge.  If one group of tasks is trashing the
> performance of another group of tasks the user is forced to use hardware
> virtualisation to work around it.
> 
> I mean, is this our answer to the updatedb problem?  Instantiate a separate
> copy of the kernel just to run updatedb?

Well even before that, I'd view the fact that working around the VM's
poor behaviour by putting updatedb into a container or memory control
as a kludge anyway. CPU and IO control (ie. nice & ioprio) is reasonable.

updatedb is pretty simple and the VM should easily be able to recognise
its use-once nature.

However I don't doubt that people would like to be able to manage memory
better. Whether that is best served by having resource control heirarchies
or virtualisation or something else completely is still on the table IMO.

> 
> 
>>unless you are willing to isolate memory
>>management, pagecache, slab caches, network and disk IO, etc.
> 
> 
> Well yes.  Ideally and ultimately.  People have done this, and it's in
> production.  We need to see (and work upon) the patches before we can judge
> whether we want to do this, and how far we want to go.

Definitely.

> 
> 
>>Again, I don't care about the solutions at this stage. I want to know
>>what the problem is. Please?
> 
> 
> Isolation.  To prevent one group of processes from damaging the performance
> of other groups, by providing manageability of the resource consumption of
> each group.  There are plenty of applications of this, not just
> server-consolidation-via-server-virtualisation.

OK... let me put it more clearly. What are the requirements?
I don't like that apparently virtualisation can't be discussed in
a general thread about resource control. Nothing is going to be a
100% solution for everybody. If, for a *specific* application,
virtualisation can be discounted... then great, that is the kind
of discussion I would like to see.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
