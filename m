Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWEIV4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWEIV4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWEIV4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:56:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:3534 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751185AbWEIV4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:56:35 -0400
From: Andi Kleen <ak@suse.de>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Date: Tue, 9 May 2006 23:56:28 +0200
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <200605091831.37757.ak@suse.de> <20060509204207.GQ7834@cl.cam.ac.uk>
In-Reply-To: <20060509204207.GQ7834@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605092356.28818.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Everything[1] in line:
> -rwxr-xr-x  1 cl349 cl349  2633640 May  9 19:42 vmlinux-inline-stripped
> Everything out of line:
> -rwxr-xr-x  1 cl349 cl349  2621352 May  9 19:45 vmlinux-outline-stripped
> 
> Additionally, I changed did a build with only __sti and __restore_flags
> out of line and the others in line:
> -rwxr-xr-x  1 cl349 cl349  2617256 May  9 19:50 vmlinux-hybrid-stripped
> 
> __sti and __restore_flags are the ones which generate more code,
> so it seemed more sensible to make the out of line.
> 
> Any conlusions?

It looks like hybrid is a clear winner at least from the code size, isn't it?

I doubt you will be able to benchmark the difference for anything else
anyways so might as well aim for that.

-Andi
