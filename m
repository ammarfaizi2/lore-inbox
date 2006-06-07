Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWFGVtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWFGVtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWFGVtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:49:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbWFGVtu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:49:50 -0400
Date: Wed, 7 Jun 2006 14:49:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Get rid of /proc/sys/debug
Message-ID: <20060607144957.6a1dcd2e@dxpl.pdx.osdl.net>
In-Reply-To: <20060607144512.1e5b0e96.rdunlap@xenotime.net>
References: <20060607142127.37da7eb7@localhost.localdomain>
	<20060607142232.6cc6cd2f@localhost.localdomain>
	<20060607144512.1e5b0e96.rdunlap@xenotime.net>
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 14:45:12 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Wed, 7 Jun 2006 14:22:32 -0700 Stephen Hemminger wrote:
> 
> > Another empty table with no entries.
> 
> Did you check on x86_64?  I see this:
> 
> rddunlap@midway:/var/linsrc/linux-2617-rc6> ll /proc/sys/debug
> -rw-r--r--  1 root root 0 2006-06-07 14:44 exception-trace
> 
> from arch/x86_64/mm/init.c

It looks like if we left the CTL_DEBUG enum, then the x86_64 code would
still work because it registers starting at /proc/sys so the debug directory
would then be created only if needed.

