Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269941AbUJHBHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269941AbUJHBHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269956AbUJHBHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:07:15 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:46384 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269941AbUJHBF4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 21:05:56 -0400
Subject: Re: 2.6.9-rc3-mm3
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041007155441.5a8e8e3a.akpm@osdl.org>
References: <20041007015139.6f5b833b.akpm@osdl.org>
	 <200410071041.20723.sandersn@btinternet.com>
	 <20041007025007.77ec1a44.akpm@osdl.org>
	 <20041007114040.GV9106@holomorphy.com>
	 <1097184341l.10532l.0l@werewolf.able.es>
	 <1097185597l.10532l.1l@werewolf.able.es>
	 <20041007150708.5d60e1c3.akpm@osdl.org>
	 <1097188883l.6408l.1l@werewolf.able.es>
	 <20041007155441.5a8e8e3a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097197542.5966.6.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 07 Oct 2004 20:05:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 17:54, Andrew Morton wrote:
> > - e100 fix (only thing I have seen at the moment...)
> 
> What's this and why is it needed?

It prevents a warning caused by calling
enable_irq() when the interrupt enable depth is already 0.
The maintainer added this call as part of a patch
that was meant to fix an unclaimed interrupt
during hardware initialization. He is
reworking the patch to do the correct thing.

You decided to keep the warning (and not apply
the e100 patch referenced in this thread) as an
indicator that a real fix is pending.

-- 
Paul Fulghum
paulkf@microgate.com


