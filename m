Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932799AbWKMTVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799AbWKMTVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932812AbWKMTVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:21:38 -0500
Received: from mga05.intel.com ([192.55.52.89]:34996 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932799AbWKMTVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:21:37 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="15260681:sNHT19557792"
Date: Mon, 13 Nov 2006 10:58:19 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061113105819.E17720@unix-os.sc.intel.com>
References: <20061111151414.GA32507@elte.hu> <200611131529.46464.ak@suse.de> <20061113150415.GA20321@elte.hu> <200611131710.13285.ak@suse.de> <20061113163216.GA3480@elte.hu> <20061113100352.C17720@unix-os.sc.intel.com> <20061113184255.GA25528@elte.hu> <20061113103051.D17720@unix-os.sc.intel.com> <20061113190452.GA29109@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061113190452.GA29109@elte.hu>; from mingo@elte.hu on Mon, Nov 13, 2006 at 08:04:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 08:04:52PM +0100, Ingo Molnar wrote:
> * Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
> > On Mon, Nov 13, 2006 at 07:42:56PM +0100, Ingo Molnar wrote:
> > > but i'd be fine with never going into cluster mode, instead always 
> > > using physical flat mode when having more than 8 APICs (independent 
> > > of the presence of CPU hotplug). On small systems, logical flat mode 
> > > is what is the best-tested variant (it's also slightly faster).
> > 
> > Ok.
> 
> ok, that's really good. Is there any 'weird' platform that you are aware 
> of that absolutely needs clustered APIC mode (because it has no physical 
> delivery mode or something)?

None that I am aware of, atleast in the x86_64 world.
