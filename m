Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVAYAEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVAYAEu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVAXXVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:21:42 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:17093 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261707AbVAXWyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:54:55 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: davidm@hpl.hp.com
Cc: bgerst@didntduck.org, Terence Ripperda <tripperda@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get 
In-reply-to: Your message of "Mon, 24 Jan 2005 14:52:06 -0800."
             <16885.31766.730042.408639@napali.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jan 2005 09:54:36 +1100
Message-ID: <31189.1106607276@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005 14:52:06 -0800, 
David Mosberger <davidm@napali.hpl.hp.com> wrote:
>>>>>> On Tue, 25 Jan 2005 09:44:18 +1100, Keith Owens <kaos@ocs.com.au> said:
>
>  Keith> Does the kernel code really need optional dynamic references
>  Keith> between modules or kernel -> modules?  That depends on how
>  Keith> people code their modules.  If the rest of the kernel no
>  Keith> longer needs dynamic symbol reference then drop
>  Keith> inter_module_* and __symbol_*.
>
>Well, the only place that I know of where I (have to) care about
>inter_module*() is because of the DRM/AGP dependency.  I can't imagine
>DRM being overly happy if an AGP device suddenly disappeared, so I
>think static is fine (in fact, probably preferable).

Does DRM support this model?

* Start DRM without AGP.
* AGP is loaded.
* DRM continues but now using AGP.

If yes then it needs dynamic symbol resolution.

