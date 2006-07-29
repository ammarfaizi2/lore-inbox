Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161404AbWG2Ch3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbWG2Ch3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 22:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161405AbWG2Ch3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 22:37:29 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:14505
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1161404AbWG2Ch2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 22:37:28 -0400
Subject: Re: 2.6.18-rc2-mm1 timer int 0 doesn't work
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       ebiederm@xmission.com
In-Reply-To: <20060728182450.8f5cbf76.akpm@osdl.org>
References: <20060727015639.9c89db57.akpm@osdl.org>
	 <1154112276.3530.3.camel@amdx2.microgate.com>
	 <20060728144854.44c4f557.akpm@osdl.org> <20060728233851.GA35643@muc.de>
	 <1154132126.3349.8.camel@localhost.localdomain>
	 <1154135792.2557.7.camel@localhost.localdomain>
	 <20060728182450.8f5cbf76.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 21:37:13 -0500
Message-Id: <1154140633.2714.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 18:24 -0700, Andrew Morton wrote:
> yeah, sorry, that's a known problem which nobody appears to be doing
> anything about.  The expansion of NR_IRQS gobbles all the percpu memory in
> the kstat structure.
> 
> I assume you have a large NR_CPUS?  Decreasing it should help.

It was using the Fedora Core 5 default of 255.
Reducing it to 2 makes it work.

So the timer int 0 problem is specific to the machine.
I'm guessing that the cheap HP machine using the ATI chipset
is one of the boards Andi was talking about.

--
Paul



