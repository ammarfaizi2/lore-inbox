Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030810AbWKOSYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030810AbWKOSYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030811AbWKOSYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:24:23 -0500
Received: from gw.goop.org ([64.81.55.164]:60293 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030810AbWKOSYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:24:22 -0500
Message-ID: <455B5B55.20803@goop.org>
Date: Wed, 15 Nov 2006 10:24:21 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org>	 <1158047806.2992.7.camel@laptopd505.fenrus.org>	 <200611151227.04777.dada1@cosmosbay.com> <200611151232.31937.ak@suse.de>	 <20061115172003.GA20403@elte.hu>  <455B4E2F.7040408@goop.org> <1163613702.31358.145.camel@laptopd505.fenrus.org>
In-Reply-To: <1163613702.31358.145.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> segment register accesses really are not cheap. 
> Also really it'll be better to use the register userspace is not using,
> but we had that discussion before; could you remind me why you picked 
> %gs in the first place?
>   

To leave open the possibility of using the compiler's TLS support in the
kernel for percpu.  I also measured the cost of reloading %gs vs %fs,
and found no difference between reloading a null selector vs a non-null
selector.

    J

