Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUG0QXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUG0QXx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266458AbUG0QWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 12:22:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:3834 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266460AbUG0QWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 12:22:14 -0400
Message-ID: <410680E0.1090802@austin.ibm.com>
Date: Tue, 27 Jul 2004 11:20:48 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: akpm@osdl.org, anton@samba.org, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu hotplug ppc64 bug
References: <410594FF.5040307@austin.ibm.com> <16646.21807.210253.45979@cargo.ozlabs.ibm.com>
In-Reply-To: <16646.21807.210253.45979@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that function pointers are a good idea too.  But I'm not sure 
why that should hold up this patch.  As it stands now all ppc64 
platforms that do hotplug happen to be pSeries.  I don't know of any 
other ppc64 platforms that are not pSeries who plan on doing this in the 
next few years.  The function is already pSeries specific anyway with 
the rtas_stop_self call.

Meanwhile if we do not put this patch in all Power5 machines will be 
unable to do cpu hotplug with a mainline kernel.



> I wanted to do this a bit differently - I was going to make cpu_die be
> a platform-specific function called via a ppc_md function pointer,
> rather than putting very pseries-specific stuff in smp.c, which is
> used on all platforms.  But having been on vacation and then
> travelling, I haven't got to it yet.
> 
> Paul.
> 
