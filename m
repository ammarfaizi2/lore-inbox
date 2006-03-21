Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWCUXTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWCUXTf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 18:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWCUXTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 18:19:35 -0500
Received: from silver.veritas.com ([143.127.12.111]:59463 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751840AbWCUXTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 18:19:34 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.03,116,1141632000"; 
   d="scan'208"; a="36229557:sNHT98214432"
Date: Tue, 21 Mar 2006 23:20:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142974347.29199.87.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.61.0603212316001.16342@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org>  <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
  <1142523201.25297.56.camel@camp4.serpentine.com> 
 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com> 
 <1142538765.10950.16.camel@serpentine.pathscale.com> 
 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
 <1142974347.29199.87.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Mar 2006 23:19:33.0510 (UTC) FILETIME=[E9A84260:01C64D3D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2006, Bryan O'Sullivan wrote:
> 
> On 2.6.15, this all "works", but I have the poor kernel thinking it
> loses 4.5MB of memory on every run.  On 2.6.16-rc6, I get a BUG.  I'll
> have to do a bit of work to reproduce it, so I can't paste it here yet.
> 
> So my quandary is thus: what am I doing wrong?  It seems that my calls
> to get_page are more or less correct, but should I be doing a put_page
> somewhere, too, such as when the char dev's release method is called,
> prior to calling dma_free_coherent?

Please mail me your source (I guess as a patch against 2.6.15),
and tomorrow I'll try to see if I can work out the leak; probably
won't work out the BUG until you can send us the messages - thanks.

Hugh
