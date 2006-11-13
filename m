Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755317AbWKMS1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbWKMS1O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755318AbWKMS1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:27:13 -0500
Received: from mga07.intel.com ([143.182.124.22]:27690 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1755317AbWKMS1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:27:13 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="145524636:sNHT529171580"
Date: Mon, 13 Nov 2006 10:03:52 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113100352.C17720@unix-os.sc.intel.com>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de> <20061113163216.GA3480@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061113163216.GA3480@elte.hu>; from mingo@elte.hu on Mon, Nov 13, 2006 at 05:32:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 05:32:16PM +0100, Ingo Molnar wrote:
> * Andi Kleen <ak@suse.de> wrote:
> > Ok assuming temporarily it's a bug, how would you want to fix it?
> 
> for that i'd have to know the bug, and this is the third time i'm asking 
> about specifics :-) (The URL that was given in the thread was about a 
> chipset bug regarding incompatibility with clustered-APIC mode - my 
> patch in fact - because it switches small systems to use logical flat 
> mode always - solves that kind of regression too.)

Not really. That chipset belongs to a MP platform and with your proposed patch,
we will endup using clustered APIC mode and will hit the issue(in the presence
of cpu hotplug) mentioned in that URL.

We will find out if this behavior is specific to this single chipset and getback
to you.

thanks,
suresh
