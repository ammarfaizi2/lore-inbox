Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWC2NsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWC2NsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWC2NsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:48:00 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:12934 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750731AbWC2Nr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:47:59 -0500
Date: Wed, 29 Mar 2006 15:47:58 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
       akpm@osdl.org, sam@vilain.net, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Pavel Emelianov <xemul@sw.ru>, Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060329134758.GB14522@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	"Eric W. Biederman" <ebiederm@xmission.com>, haveblue@us.ibm.com,
	linux-kernel@vger.kernel.org, devel@openvz.org, serue@us.ibm.com,
	akpm@osdl.org, sam@vilain.net,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Pavel Emelianov <xemul@sw.ru>, Stanislav Protassov <st@sw.ru>
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <4428FB90.5000601@sw.ru> <4428FEA5.9020808@yahoo.com.au> <4429E534.8030206@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4429E534.8030206@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 05:39:00AM +0400, Kirill Korotaev wrote:
> Nick,
> 
> >>First of all, what it does which low level virtualization can't:
> >>- it allows to run 100 containers on 1GB RAM
> >>  (it is called containers, VE - Virtual Environments,
> >>   VPS - Virtual Private Servers).
> >>- it has no much overhead (<1-2%), which is unavoidable with hardware
> >>  virtualization. For example, Xen has >20% overhead on disk I/O.
> >
> >Are any future hardware solutions likely to improve these problems?
> Probably you are aware of VT-i/VT-x technologies and planned virtualized 
> MMU and I/O MMU from Intel and AMD.
> These features should improve the performance somehow, but there is 
> still a limit for decreasing the overhead, since at least disk, network, 
> video and such devices should be emulated.
> 
> >>OS kernel virtualization
> >>~~~~~~~~~~~~~~~~~~~~~~~~
> >
> >Is this considered secure enough that multiple untrusted VEs are run
> >on production systems?
> it is secure enough. What makes it secure? In general:
> - virtualization, which makes resources private
> - resource control, which makes VE to be limited with its usages
> In more technical details virtualization projects make user access (and 
> capabilities) checks stricter. Moreover, OpenVZ is using "denied by 
> default" approach to make sure it is secure and VE users are not allowed 
> something else.
> 
> Also, about 2-3 month ago we had a security review of OpenVZ project 
> made by Solar Designer. So, in general such virtualization approach 
> should be not less secure than VM-like one. VM core code is bigger and 
> there is enough chances for bugs there.
> 
> >What kind of users want this, who can't use alternatives like real
> >VMs?
> Many companies, just can't share their names. But in general no 
> enterprise and hosting companies need to run different OSes on the same 
> machine. For them it is quite natural to use N machines for Linux and M 
> for Windows. And since VEs are much more lightweight and easier to work 
> with, they like it very much.
> 
> Just for example, OpenVZ core is running more than 300,000 VEs worldwide.

not bad, how did you get to those numbers?
and, more important, how many of those are actually OpenVZ?
(compared to Virtuozzo(tm))

best,
Herbert

> Thanks,
> Kirill
