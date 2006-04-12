Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWDLSWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWDLSWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWDLSWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 14:22:53 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:33809 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932307AbWDLSWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 14:22:52 -0400
Message-ID: <443D4575.1090506@mvista.com>
Date: Wed, 12 Apr 2006 13:22:45 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       minyard@mvista.com
Subject: Re: [PATCH] IPMI: fix devinit placement
References: <20060412110557.dc03c0f8.rdunlap@xenotime.net>
In-Reply-To: <20060412110557.dc03c0f8.rdunlap@xenotime.net>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me. Thanks.

-Corey

Randy.Dunlap wrote:

>From: Randy Dunlap <rdunlap@xenotime.net>
>
>gcc complains about __devinit in the wrong location:
>drivers/char/ipmi/ipmi_si_intf.c:2205: warning: '__section__' attribute does not apply to types
>
>Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
>---
> drivers/char/ipmi/ipmi_si_intf.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
>--- linux-2617-rc1g5.orig/drivers/char/ipmi/ipmi_si_intf.c
>+++ linux-2617-rc1g5/drivers/char/ipmi/ipmi_si_intf.c
>@@ -2198,11 +2198,11 @@ static inline void wait_for_timer_and_th
> 	}
> }
> 
>-static struct ipmi_default_vals
>+static __devinit struct ipmi_default_vals
> {
> 	int type;
> 	int port;
>-} __devinit ipmi_defaults[] =
>+} ipmi_defaults[] =
> {
> 	{ .type = SI_KCS, .port = 0xca2 },
> 	{ .type = SI_SMIC, .port = 0xca9 },
>
>
>---
>  
>

