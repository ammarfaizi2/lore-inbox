Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVAXW6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVAXW6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVAXW6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:58:11 -0500
Received: from palrel11.hp.com ([156.153.255.246]:1241 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261711AbVAXWwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:52:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16885.31766.730042.408639@napali.hpl.hp.com>
Date: Mon, 24 Jan 2005 14:52:06 -0800
To: Keith Owens <kaos@ocs.com.au>
Cc: davidm@hpl.hp.com, bgerst@didntduck.org,
       Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get 
In-Reply-To: <30494.1106606658@ocs3.ocs.com.au>
References: <16885.30810.787188.591830@napali.hpl.hp.com>
	<30494.1106606658@ocs3.ocs.com.au>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 25 Jan 2005 09:44:18 +1100, Keith Owens <kaos@ocs.com.au> said:

  Keith> Does the kernel code really need optional dynamic references
  Keith> between modules or kernel -> modules?  That depends on how
  Keith> people code their modules.  If the rest of the kernel no
  Keith> longer needs dynamic symbol reference then drop
  Keith> inter_module_* and __symbol_*.

Well, the only place that I know of where I (have to) care about
inter_module*() is because of the DRM/AGP dependency.  I can't imagine
DRM being overly happy if an AGP device suddenly disappeared, so I
think static is fine (in fact, probably preferable).

Of course, the trick is how to pull the backwards compatibility off
giving that for the time being we're more or less stuck with Nvidia's
5336 release on ia64... ;-(

	--david
