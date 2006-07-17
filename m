Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWGQTlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWGQTlG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 15:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWGQTlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 15:41:05 -0400
Received: from mail.suse.de ([195.135.220.2]:61669 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750907AbWGQTlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 15:41:04 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix recursive fault in page-fault handler
Date: Mon, 17 Jul 2006 21:41:53 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Krzysztof Halasa <khc@pm.waw.pl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200607171322_MC3-1-C53B-6253@compuserve.com>
In-Reply-To: <200607171322_MC3-1-C53B-6253@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607172141.53875.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 July 2006 19:19, Chuck Ebbert wrote:
> Krzysztof Halasa reported recursive faults in do_page_fault()
> causing a stream of partial oops messages on the console. Fix
> by adding a fixup for that code.

Please just use __put_user, no need to do it in full inline assembly

-Andi

