Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbVI3W5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVI3W5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030498AbVI3W5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:57:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030497AbVI3W5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:57:07 -0400
Date: Fri, 30 Sep 2005 18:56:32 -0400
From: Dave Jones <davej@redhat.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
Message-ID: <20050930225632.GE15160@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20050929190419.C15943@unix-os.sc.intel.com> <433D391A.70607@vc.cvut.cz> <20050930112310.A28092@unix-os.sc.intel.com> <200510010002.16382.ak@suse.de> <20050930152358.D28092@unix-os.sc.intel.com> <433DBE33.7090700@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433DBE33.7090700@vc.cvut.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2005 at 12:37:39AM +0200, Petr Vandrovec wrote:
 > Siddha, Suresh B wrote:
 > >On Sat, Oct 01, 2005 at 12:02:16AM +0200, Andi Kleen wrote:
 > >
 > >>I applied an earlier mix of your original one and Petr's suggestions. 
 > >>Hope it's ok. 
 > >
 > >
 > >Andi I prefer to follow the SDM guidelines. Who knows if future families
 > >comeup with a different rule or use/initialize these extended model/family
 > >bits differently. I am just being paranoid.
 > 
 > And which chance is bigger - that such hypothetical processor will use
 > extended model, and your code will get incorrect answer everywhere, or
 > that such hypothetical processor will not use extended model, and your
 > code will be right?
 > 
 > >>+		if (c->x86 >= 0xf) 
 > >
 > >
 > >And also you have a typo. It should be 0x6.
 > 
 > It is intentional.  Maybe it could do BUG_ON(c->x86 < 0xf).

<complete speculation> Pentium M is family 6, so maybe this is
an indication we'll see em64t capable P-M's soon ? :)

		Dave

