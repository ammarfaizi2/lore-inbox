Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVAXWho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVAXWho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVAXWgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:36:42 -0500
Received: from palrel10.hp.com ([156.153.255.245]:16010 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261705AbVAXWgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:36:18 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.30810.787188.591830@napali.hpl.hp.com>
Date: Mon, 24 Jan 2005 14:36:10 -0800
To: kaos@ocs.com.au
Cc: bgerst@didntduck.org, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get
In-Reply-To: <8829.1105153800@ocs3.ocs.com.au>
References: <8829.1105153800@ocs3.ocs.com.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,

I didn't see any followup to your message.  My apologies if I missed
something.

You wrote:

 Keith> inter_module_* and __symbol_* solve these class of problems:

 Keith> Module A can use module B if B is loaded, but A does not
 Keith> require module B to do its work.  B is optional.

 Keith> The kernel can use code in module C is C is loaded, but the
 Keith> base kernel does not require module C.  C is optional.

Why isn't this handled via weak references?  If the reference comes
out as 0, you know the underlying module/facility isn't there and
proceed accordingly.

	--david
