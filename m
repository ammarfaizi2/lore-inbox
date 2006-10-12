Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWJLShP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWJLShP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWJLShP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:37:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51167 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750736AbWJLShN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:37:13 -0400
Subject: Re: Can context switches be faster?
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <452E888D.6040002@comcast.net>
References: <452E62F8.5010402@comcast.net>
	 <20061012171929.GB24658@flint.arm.linux.org.uk>
	 <452E888D.6040002@comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 12 Oct 2006 20:37:11 +0200
Message-Id: <1160678231.3000.451.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 14:25 -0400, John Richard Moser wrote:

Hi,

> So apparently most CPUs virtually address L1 cache and physically
> address L2; but sometimes physically addressing L1 is better.. hur.

if you are interested in this I would strongly urge you to read Curt
Schimmel's book (UNIX(R) Systems for Modern Architectures: Symmetric
Multiprocessing and Caching for Kernel Programmers); it explains this
and related materials really really well.


>   - Does the current code act on these behaviors, or just flush all
>     cache regardless?

the cache flushing is a per architecture property. On x86, the cache
flushing isn't needed; but a TLB flush is. Depending on your hardware
that can be expensive as well. 

Greetings,
    Arjan van de Ven

