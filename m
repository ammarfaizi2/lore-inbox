Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbVLOStx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbVLOStx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbVLOStw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:49:52 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:27587 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750911AbVLOStw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:49:52 -0500
Subject: RE: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@osdl.org>,
       Mark Lord <lkml@rtr.ca>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk,
       pj@sgi.com, mingo@elte.hu, hch@infradead.org, torvalds@osdl.org,
       arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0535A549@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 10:48:48 -0800
Message-Id: <1134672528.3751.0.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 09:45 -0800, Luck, Tony wrote:
> There was a USENIX paper a couple of decades ago that described how
> to do a fast s/w disable of interrupts on machines where really disabling
> interrupts was expensive.  The rough gist was that the spl[1-7]()
> functions would just set a flag in memory to hold the desired interrupt
> mask.  If an interrupt actually occurred when it was s/w blocked, the
> handler would set a pending flag, and just rfi with interrupts disabled.
> Then the splx() code checked to see whether there was a pending interrupt
> and dealt with it if there was.

Would you believe that that paper was written about the NCR Voyager
architecture (The VIC is very expensive for interrupt disables) and that
the current Linux Voyager Subarchitecture still makes partial use of the
scheme.

James


