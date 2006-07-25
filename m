Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750890AbWGYSqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbWGYSqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWGYSqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:46:08 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:476 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1750890AbWGYSqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:46:06 -0400
In-Reply-To: <1153852204.5665.10.camel@basalt.austin.ibm.com>
References: <20060718091807.467468000@sous-sol.org> <20060718091956.905130000@sous-sol.org> <1153852204.5665.10.camel@basalt.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <af9f9eb1ed882cad53cbefdd1ae88c27@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       xen-ppc-devel <xen-ppc-devel@lists.xensource.com>,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 28/33] Add Xen grant table support
Date: Tue, 25 Jul 2006 19:45:51 +0100
To: Hollis Blanchard <hollisb@us.ibm.com>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Jul 2006, at 19:30, Hollis Blanchard wrote:

> I object to these uses of (synch_)cmpxchg on a uint16_t in common code.
> Many architectures, including PowerPC, do not support 2-byte atomic
> operations, but this code is common to all Xen architectures.

We'll use synch_cmpxchg_subword() in the next iteration of these 
patches. It's already been applied to our main Xen repository but 
hadn't been applied to our merge repo when these patches were created.

  -- Keir

