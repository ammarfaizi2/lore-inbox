Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWA2UJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWA2UJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 15:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWA2UJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 15:09:28 -0500
Received: from kanga.kvack.org ([66.96.29.28]:49026 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751148AbWA2UJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 15:09:28 -0500
Date: Sun, 29 Jan 2006 15:05:04 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: instead of poisoning .init zone, change protection bits to force a fault
Message-ID: <20060129200504.GD28400@kvack.org>
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com> <m17j8jfs03.fsf@ebiederm.dsl.xmission.com> <20060128235113.697e3a2c.akpm@osdl.org> <200601291620.28291.ioe-lkml@rameria.de> <20060129113312.73f31485.akpm@osdl.org> <43DD1FDC.4080302@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DD1FDC.4080302@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 09:04:44PM +0100, Eric Dumazet wrote:
> Chasing some invalid accesses to .init zone, I found that free_init_pages() 
> was properly freeing the pages but virtual was still usable.

This change will break the large table entries up, resulting in more TLB 
pressure and reducing performance, and so should only be activated as a 
debug option.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
