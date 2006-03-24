Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWCXT1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWCXT1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 14:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWCXT1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 14:27:34 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:56292 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964794AbWCXT1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 14:27:33 -0500
Subject: Re: [RFC] Virtualization steps
From: Dave Hansen <haveblue@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
In-Reply-To: <44242D4D.40702@yahoo.com.au>
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 11:25:39 -0800
Message-Id: <1143228339.19152.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 04:33 +1100, Nick Piggin wrote:
> Oh, after you come to an agreement and start posting patches, can you
> also outline why we want this in the kernel (what it does that low
> level virtualization doesn't, etc, etc) 

Can you wait for an OLS paper? ;)

I'll summarize it this way: low-level virtualization uses resource
inefficiently.

With this higher-level stuff, you get to share all of the Linux caching,
and can do things like sharing libraries pretty naturally.

They are also much lighter-weight to create and destroy than full
virtual machines.  We were planning on doing some performance
comparisons versus some hypervisors like Xen and the ppc64 one to show
scaling with the number of virtualized instances.  Creating 100 of these
Linux containers is as easy as a couple of shell scripts, but we still
can't find anybody crazy enough to go create 100 Xen VMs.

Anyway, those are the things that came to my mind first.  I'm sure the
others involved have their own motivations.

-- Dave

