Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVATLkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVATLkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 06:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVATLkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 06:40:46 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:36586 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262126AbVATLkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 06:40:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pE3VinSpJZRthQ5iwdCbem+Kyos7IMjLNpWrrg25xG5ggyJzSl0g7Jx5FxvrV6A/HYBo/SZ10z9RbWYCHuQZMtGUs0h4szEU70x+Ndt6ZYZrnSIpdUqaCvTv3FM/uxyIHDLekz4qZahfEykf4bjUvn5PYzABzNpZWiSbE5Ld1+Q=
Message-ID: <40f323d0050120034013aa346e@mail.gmail.com>
Date: Thu, 20 Jan 2005 12:40:40 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: 2.6.11-rc1-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050119213818.55b14bb0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050119213818.55b14bb0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005 21:38:18 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm2/
> 
> - There are a bunch of ioctl() and compat_ioctl() changes in here which seem
>   to be of dubious maturity.  Could people involved in this area please
>   review, test and let me know?
> 
> - A revamp of the kexec and crashdump patches.  Anyone who is interested in
>   this work, please help to get this ball rolling a little faster?
> 
> - This kernel isn't particularly well-tested, sorry.  I've been a bit tied
>   up with other stuff.
> 
> Changes since 2.6.11-rc1-mm1:
> 

>
> i386-cpu-hotplug-updated-for-mm.patch
>  i386 CPU hotplug updated for -mm

With this patch, it doesn't build on UP with local APIC :

arch/i386/kernel/nmi.c: In function `check_nmi_watchdog':
arch/i386/kernel/nmi.c:130: error: `cpu_callin_map' undeclared (first
use in this function)

(cpu_callin_map is only declared on smp)

regards,

Benoit
