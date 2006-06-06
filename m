Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWFFQYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWFFQYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWFFQYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:24:11 -0400
Received: from gw.goop.org ([64.81.55.164]:17342 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751338AbWFFQYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:24:10 -0400
Message-ID: <4485AC1F.9050001@goop.org>
Date: Tue, 06 Jun 2006 09:23:59 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: Miles Lane <miles.lane@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dzickus@redhat.com, ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in	arch/i386/kernel/nmi.c:174
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org>	 <20060605004823.566b266c.akpm@osdl.org>	 <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1149576246.32046.166.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:
> Does below patch help? The nmi suspend/resume doesn't look good to me.
> Only CPU0 uses the suspend/resume code path. Other CPUs run the CPU
> hotplug code path.
>   
Unfortunately this just oopses immediately on the first suspend.  The 
stack trace is unclear (and I'm just going from memory at the moment), 
but it looked like it got an invalid op.  I'll try to get a clearer idea 
of the crash later today.

    J
