Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbUKKFF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbUKKFF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 00:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKKFF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 00:05:26 -0500
Received: from ozlabs.org ([203.10.76.45]:5281 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262173AbUKKFFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 00:05:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16786.62032.421264.819206@cargo.ozlabs.ibm.com>
Date: Thu, 11 Nov 2004 16:02:08 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: Leo Przybylski <leo@leosandbox.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Blast and data miscompare
In-Reply-To: <20041109093400.34b49953@localhost>
References: <41847C52.8030702@leosandbox.org>
	<20041109093400.34b49953@localhost>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen writes:

> Not sure if it's the same problem.  But we were seeing a miscompare on
> 2.4 due to a incorrect COW happening, followed by a hardware hash hole
> w/ PPC64.
> 
> To fix it we had to make sure that the PTE was cleared and the TLB's
> flushed before the new PTE was established.
> 
> Martin, was this fixed on 2.6?

It can't happen on 2.6; when BenH rewrote the PTE handling in 2.6
earlier this year, this was one of the things we made sure couldn't be
a problem.

Paul.
