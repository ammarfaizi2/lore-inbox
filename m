Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWC1U0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWC1U0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWC1U0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:26:10 -0500
Received: from s93.xrea.com ([218.216.67.44]:10639 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S932148AbWC1U0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:26:09 -0500
Message-Id: <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Date: Wed, 29 Mar 2006 05:29:43 +0900
To: devel@openvz.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, serue@us.ibm.com
Subject: Re: [Devel] Re: [RFC] Virtualization steps
In-Reply-To: <1143228339.19152.91.camel@localhost.localdomain>
References: <1143228339.19152.91.camel@localhost.localdomain>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>I'll summarize it this way: low-level virtualization uses resource
>inefficiently.
>
>With this higher-level stuff, you get to share all of the Linux caching,
>and can do things like sharing libraries pretty naturally.
>
>They are also much lighter-weight to create and destroy than full
>virtual machines.  We were planning on doing some performance
>comparisons versus some hypervisors like Xen and the ppc64 one to show
>scaling with the number of virtualized instances.  Creating 100 of these
>Linux containers is as easy as a couple of shell scripts, but we still
>can't find anybody crazy enough to go create 100 Xen VMs.
>
>Anyway, those are the things that came to my mind first.  I'm sure the
>others involved have their own motivations.
>

Some questions.

1. Your point is rignt in some ways, and I agree with you.
   Yes, I currently guess Jail is quite practical than Xen.
   Xen sounds cool, but really practical? I doubt a bit.
   But it would be a narrow thought, maybe.
   How you estimate feature improvement of memory shareing
   on VM ( e.g. Xen/VMware)?
   I have seen there are many papers about this issue.
   If once memory sharing gets much efficient, Xen possibly wins.

2. Folks, how you think about other good points of Xen,
   like live migration, or runs solaris, or has suspend/resume or...
   No Linux jails have such feature for now, although I dont think
   it is impossible with jail.


My current suggestion is,

1. Dont use Xen for running multiple VMs.
2. Use Xen for better admin/operation/deploy... tools.
3. If you need multiple VMs, use jail on Xen.

           --- Okajima, Jun. Tokyo, Japan.
               http://www.digitalinfra.co.jp/
               http://www.colinux.org/
               http://www.machboot.com/
