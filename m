Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVDMOz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVDMOz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 10:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVDMOz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 10:55:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17899 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261358AbVDMOzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 10:55:41 -0400
Date: Wed, 13 Apr 2005 10:54:25 -0400
From: Dave Jones <davej@redhat.com>
To: Yuri Vilmanis <vilmanis@internode.on.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMBOL_GPL for __symbol_get replacing EXPORT_SYMBOL for deprecated inter_module_get
Message-ID: <20050413145424.GA4797@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Yuri Vilmanis <vilmanis@internode.on.net>,
	linux-kernel@vger.kernel.org
References: <200504131855.00806.vilmanis@internode.on.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504131855.00806.vilmanis@internode.on.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 06:55:00PM +0930, Yuri Vilmanis wrote:

 > The case in point for me is ATI's binary openGL accelerated drivers (fglrx) - 
 > these used inter_module_get() to communicate with the agp gart module, for 
 > obvious reasons - this AGP communication is essential to the functionality of 
 > the driver. No, I don't like ATI only having closed-source drivers any more 
 > than you, but given the extremely competetive nature of high end video card 
 > sales, I can see why they want to do it this way.
 > ....
 > Am I take it to mean that no closed-source / binary-only driver may use AGP 
 > acceleration in the future, including ones that have in the past?

They can use the in-kernel GART driver just fine. Of course, they choose
to take a bastardised version from some ancient tree, mangle it to
all hell, strip off the GPL MODULE_VERSION, and weld it to their
own driver, but that's their decision. Which is btw, whats partly
causing your problem.  (They still would've needed to change some
code, but the AGP side of the fence would be taken care of).

		Dave

