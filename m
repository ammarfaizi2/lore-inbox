Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWGYTHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWGYTHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWGYTHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:07:04 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:65235 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S964811AbWGYTHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:07:01 -0400
In-Reply-To: <1153852204.5665.10.camel@basalt.austin.ibm.com>
References: <20060718091807.467468000@sous-sol.org> <20060718091956.905130000@sous-sol.org> <1153852204.5665.10.camel@basalt.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C39255BB-9E63-4EB6-BE9D-4CD32F830585@kernel.crashing.org>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, virtualization@lists.osdl.org,
       Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       xen-ppc-devel <xen-ppc-devel@lists.xensource.com>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 28/33] Add Xen grant table support
Date: Tue, 25 Jul 2006 21:06:51 +0200
To: Hollis Blanchard <hollisb@us.ibm.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I object to these uses of (synch_)cmpxchg on a uint16_t in common  
> code.
> Many architectures, including PowerPC, do not support 2-byte atomic
> operations, but this code is common to all Xen architectures.

RMW operations you mean, I suppose.  On PowerPC, all (naturally
aligned) halfword operations are atomic; there do not exist any
RMW operations; but word and doubleword atomic RMW operations
can be emulated.

Boils down to the same thing of course, but it isn't the same ;-)


Segher

