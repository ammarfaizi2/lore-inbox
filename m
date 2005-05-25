Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVEYRbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVEYRbz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVEYRby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:31:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48117 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261506AbVEYRbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:31:35 -0400
Message-ID: <4294B652.1090509@mvista.com>
Date: Wed, 25 May 2005 10:30:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Andrew Morton <akpm@osdl.org>, ppc64-dev <linuxppc64-dev@ozlabs.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus <torvalds@osdl.org>
Subject: Re: [PATCH] ppc64 iSeries: fix boot time setting
References: <20050525162926.7691bb34.sfr@canb.auug.org.au>
In-Reply-To: <20050525162926.7691bb34.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am I the only one who has problems with the signature mark ("-- ") prior to the 
patch.  For example, this is a reply with quoting the original message.  My 
mailer (mozilla) dropped everything after the "-- " in the original.  If someone 
knows how to change mozilla to fix this, I welcome the help.

George

Stephen Rothwell wrote:
> Hi all,
> 
> For quite a while, there has existed a hypervisor bug on legacy iSeries
> which means that we do not get the boot time set in the kernel.  This
> patch works around that bug.  This was most noticable when the root
> partition needed to be checked at every boot as the kernel thought it was
> some time in 1905 until user mode reset the time correctly.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> 
>  arch/ppc64/kernel/mf.c         |   85 +++++++++++++++++++++++++++++++----------
>  arch/ppc64/kernel/rtc.c        |   39 ------------------
>  include/asm-ppc64/iSeries/mf.h |    1
>  3 files changed, 67 insertions(+), 58 deletions(-)
> 
> Please apply and send to Linus.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
