Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUELUhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUELUhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 16:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUELUhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 16:37:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:22717 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265221AbUELUh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 16:37:27 -0400
Date: Wed, 12 May 2004 13:35:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mingo@elte.hu, davidel@xmailserver.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040512133520.44fbfd39.akpm@osdl.org>
In-Reply-To: <40A28815.2020009@pobox.com>
References: <20040512020700.6f6aa61f.akpm@osdl.org>
	<20040512181903.GG13421@kroah.com>
	<40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
	<20040512200305.GA16078@elte.hu>
	<20040512132050.6eae6905.akpm@osdl.org>
	<40A28815.2020009@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > How about we do:
>  > 
>  > #if HZ=1000
>  > #define	MSEC_TO_JIFFIES(msec) (msec)
>  > #define JIFFIES_TO_MESC(jiffies) (jiffies)
>  > #elif HZ=100
>  > #define	MSEC_TO_JIFFIES(msec) (msec * 10)
>  > #define JIFFIES_TO_MESC(jiffies) (jiffies / 10)
>  > #else
>  > #define	MSEC_TO_JIFFIES(msec) ((HZ * (msec) + 999) / 1000)
>  > #define	JIFFIES_TO_MSEC(jiffies) ...
>  > #endif
>  > 
>  > in some kernel-wide header then kill off all the private implementations?
> 
> 
>  include/linux/time.h.  One of the SCTP people already did this, but I 
>  suppose it's straightforward to reproduce.

OK, I'll do it.
