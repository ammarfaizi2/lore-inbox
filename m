Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVB0WuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVB0WuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 17:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVB0WuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 17:50:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:11476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261501AbVB0WuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 17:50:09 -0500
Date: Sun, 27 Feb 2005 14:49:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: zwane@arm.linux.org.uk, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, nathanl@austin.ibm.com
Subject: Re: [PATCH] PPC64: Generic hotplug cpu support
Message-Id: <20050227144928.6c71adaf.akpm@osdl.org>
In-Reply-To: <1109542971.14993.217.camel@gaston>
References: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com>
	<20050227031655.67233bb5.akpm@osdl.org>
	<1109542971.14993.217.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > -		if (cpu_is_offline(smp_processor_id()) &&
>  > +		if (cpu_is_offline(_smp_processor_id()) &&
>  >  		    system_state == SYSTEM_RUNNING)
>  >  			cpu_die();
>  >  	}
>  > _
> 
>  This is the idle loop. Is that ever supposed to be preempted ?

Nope, it's a false positive.  We had to do the same in x86's idle loop and
probably others will hit it.

