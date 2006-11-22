Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756735AbWKVTzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbWKVTzf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756757AbWKVTzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:55:35 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:10387 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1756735AbWKVTze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:55:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=To+yImZMCkXJcV8F/PFmp8JOrEsAdgEZkExZpre5MxPeZOgvwcDTslbwjRmZOBUFT2cc0MLz3EkxmFy1ozIiHUxx+Sadb9XH4BWj+oD12WfSIXUOj2LJZQ1Nh56GltIqzeQ+hC0voXHpKJzkktNily3iFH57kxv5tgzp7MX3KO8=  ;
X-YMail-OSG: o7mIQ.MVM1ku7pATFFetRiTNMy3EhdtvREeyrkYEBmncwyiTjAJ93U9fS.tBlkoQWPDXn3dOLDjRYoVN1fRWlW8rRxz2e4RO2Aygs733RGI3NiRCzb0ZUw--
From: David Brownell <david-b@pacbell.net>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: NTP time sync
Date: Wed, 22 Nov 2006 11:55:23 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
       Kim Phillips <kim.phillips@freescale.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, akpm@osdl.org, davem@davemloft.net,
       kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org,
       ralf@linux-mips.org, rmk@arm.linux.org.uk
References: <20061122203633.611acaa8@inspiron>
In-Reply-To: <20061122203633.611acaa8@inspiron>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611221155.26686.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 November 2006 11:36 am, Alessandro Zummo wrote:
> 
>  wrto the in-kernel NTP synchronization,
>  as discussed before [1], my opinion
>  is that it should be done in userland.
> 
>  Keeping it in kernel implies subtle code
>  in each of the supported architectures.
> 
>  So, if the arch maintainers agree, 
>  I would suggest to schedule it for removal.
> 
> [1] http://lkml.org/lkml/2006/3/28/358

Suggested time of removal: one year after two relevant software
package releases get updated:

  - NTPD, to call hwclock specifying the relevant RTC;
  - util-linux, updating hwclock to know about /dev/rtcN;
  - busybox, with its own hwclock implementation.

The util-linux hwclock update is already in the queue, I'm told.

- Dave
