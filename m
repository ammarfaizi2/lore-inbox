Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUK1XiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUK1XiC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUK1XiC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:38:02 -0500
Received: from ozlabs.org ([203.10.76.45]:20415 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261602AbUK1Xhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:37:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
Date: Mon, 29 Nov 2004 10:37:33 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041127032403.GB10536@kroah.com>
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> The justification is that it doesn't properly describe the variable size
> (think userspace 32 bit variable vs. kernelspace 32 bit variable.)  We
> need to stick with the proper __u32 type variables for data that crosses
> the userspace/kernelspace boundry.

uint32_t is defined to be exactly 32 bits wide, so where's the problem
in using it instead of __u32 in the headers that describe the
user/kernel interface?  (Ditto for uint{8,16,64}_t, of course.)

Paul.
