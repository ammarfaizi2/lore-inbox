Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbWIDNAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbWIDNAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 09:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWIDNAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 09:00:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59919 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964838AbWIDNAh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 09:00:37 -0400
Date: Mon, 4 Sep 2006 12:59:21 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adam Belay <abelay@novell.com>
Cc: Len Brown <len.brown@intel.com>, ACPI ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH 1/2] ACPI: Idle Processor PM Improvements
Message-ID: <20060904125921.GB6279@ucw.cz>
References: <1156884681.1781.120.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156884681.1781.120.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch improves the ACPI c-state selection algorithm.  It also
> includes a major cleanup and simplification of the processor idle code.

Nice!

> @@ -1009,7 +883,7 @@
>  
>  	seq_printf(seq, "active state:            C%zd\n"
>  		   "max_cstate:              C%d\n"
> -		   "bus master activity:     %08x\n",
> +		   "bus master activity:     %d\n",
>  		   pr->power.state ? pr->power.state - pr->power.states : 0,
>  		   max_cstate, (unsigned)pr->power.bm_activity);
>  

This changes kernel - user interface. You should change the field
description, or keep it in hex...

BTW will you be on september's labs conference?

							Pavel
-- 
Thanks for all the (sleeping) penguins.
