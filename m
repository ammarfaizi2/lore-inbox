Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932785AbWKMSyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932785AbWKMSyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbWKMSx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:53:59 -0500
Received: from mga05.intel.com ([192.55.52.89]:21388 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1755321AbWKMSx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:53:59 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="15250190:sNHT19845594"
Date: Mon, 13 Nov 2006 10:30:51 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113103051.D17720@unix-os.sc.intel.com>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de> <20061113163216.GA3480@elte.hu> <20061113100352.C17720@unix-os.sc.intel.com> <20061113184255.GA25528@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061113184255.GA25528@elte.hu>; from mingo@elte.hu on Mon, Nov 13, 2006 at 07:42:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 07:42:56PM +0100, Ingo Molnar wrote:
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > Not really. That chipset belongs to a MP platform and with your 
> > proposed patch, we will endup using clustered APIC mode and will hit 
> > the issue(in the presence of cpu hotplug) mentioned in that URL.
> 
> hm, why does it end up in clustered mode? Cluster mode should only 
> trigger if the APIC IDs go beyond 16.

go beyond '8' not 16. With Dual-core+HT these MP platforms will have 16 logical
cpus.

> 
> but i'd be fine with never going into cluster mode, instead always using 
> physical flat mode when having more than 8 APICs (independent of the 
> presence of CPU hotplug). On small systems, logical flat mode is what is 
> the best-tested variant (it's also slightly faster).

Ok.

thanks,
suresh
