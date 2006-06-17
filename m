Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWFQIsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWFQIsZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 04:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWFQIsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 04:48:25 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:51825 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750811AbWFQIsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 04:48:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=yENzU6FpK3tZ/CIQw/Ys7UgTjn3E7ueOpEuX77cwhbL5kDuolNR/6RsGB072Xeik1KrL3/d/p+dp8G+X8c9NMJQuYmA3KZH64QFFjdjt7Gt/nzy1cq5Q8lgGxMhH4MzO4rSP9R3T96byFkAxHNe7mM1XePQRX+MlgibAbQGTioU=  ;
Message-ID: <4493C1D1.4020801@yahoo.com.au>
Date: Sat, 17 Jun 2006 18:48:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Sam Vilain <sam@vilain.net>, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>, Andrew Morton <akpm@osdl.org>,
       sekharan@us.ibm.com, Balbir Singh <balbir@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] CPU controllers?
References: <20060615134632.GA22033@in.ibm.com>
In-Reply-To: <20060615134632.GA22033@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> Hello,
> 	There have been several proposals so far on this subject and no
> consensus seems to have been reached on what an acceptable CPU controller
> for Linux needs to provide. I am hoping this mail will trigger some
> discussions in that regard. In particular I am keen to know what the
> various maintainers think about this subject.
> 
> The various approaches proposed so far are:
> 
> 	- CPU rate-cap (limit CPU execution rate per-task)
> 		http://lkml.org/lkml/2006/5/26/7	
> 
> 	- f-series CKRM controller (CPU usage guarantee for a task-group)
> 		http://lkml.org/lkml/2006/4/27/399
> 
> 	- e-series CKRM controller (CPU usage guarantee/limit for a task-group)
> 		http://prdownloads.sourceforge.net/ckrm/cpu.ckrm-e18.v10.patch.gz?download
> 
> 	- OpenVZ controller (CPU usage guarantee/hard-limit for a task-group)
> 		http://openvz.org/
> 
> 	- vserver controller (CPU usage guarantee(?)/limit for a task-group)
> 		http://linux-vserver.org/
> 
> (I apologize if I have missed any other significant proposal for Linux)
> 
> Their salient features and limitations/drawbacks, as I could gather, are 
> summarized later below. To note is each controller varies in degree of 
> complexity and addresses its own set of requirements. 
> 
> In going forward for an acceptable controller in mainline it would help, IMHO, 
> if we put together the set of requirements which the Linux CPU controller 
> should support. Some questions that arise in this regard are:
> 
> 	- Do we need mechanisms to control CPU usage of tasks, further to what
> 	  already exists (like nice)?  IMO yes.

Can we get back to the question of need? And from there, work out what
features are wanted.

IMHO, having containers try to virtualise all resources (memory, pagecache,
slab cache, CPU, disk/network IO...) seems insane: we may just as well use
virtualisation.

So, from my POV, I would like to be convinced of the need for this first.
I would really love to be able to keep core kernel simple and fast even if
it means edge cases might need to use a slightly different solution.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
