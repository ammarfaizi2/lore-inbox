Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbUC3T1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbUC3T1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:27:17 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:56054 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263855AbUC3T1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:27:13 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Date: Tue, 30 Mar 2004 11:27:05 -0800
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>
References: <20040317201454.5b2e8a3c.akpm@osdl.org>
In-Reply-To: <20040317201454.5b2e8a3c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403301127.05151.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 March 2004 8:14 pm, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6
>.5-rc1-mm2/
>
> - Dropped the early-x86-cpu-detection patches, as these appear to be the
>   source of recent early-crash problems.
>
> - Several fixes against the new writeback code.
>
> - Several fixes against the new block unplugging code.

I just tracked down a hang I've been seeing in the 2.6.5-rcX-mm trees to this 
release.  The symptom is that the machine hangs sometime during init script 
startup, usually at around the time swap space is enabled (using pretty stock 
Red Hat scripts).  Before I look into it any further, are there any patches 
that I should look at dropping to see if the hang goes away?

The hang occurs all the way through 2.6.5-rc3-mm1, but Linus' 2.6.5-rc3 
release works fine.

Thanks,
Jesse
