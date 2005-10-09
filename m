Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVJIPku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJIPku (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 11:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbVJIPku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 11:40:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:21446 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750700AbVJIPkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 11:40:49 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17225.14866.282917.300312@tut.ibm.com>
Date: Sun, 9 Oct 2005 10:41:06 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [RFC] gfp flags annotations - part 6 (simple parts of fs/*)
In-Reply-To: <20051009055549.GK7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk>
	<20050905212026.GL5155@ZenIV.linux.org.uk>
	<20050907183131.GF5155@ZenIV.linux.org.uk>
	<20050912191744.GN25261@ZenIV.linux.org.uk>
	<20050912192049.GO25261@ZenIV.linux.org.uk>
	<20050930120831.GI7992@ftp.linux.org.uk>
	<20051004203009.GQ7992@ftp.linux.org.uk>
	<20051005202904.GA27229@mipter.zuzino.mipt.ru>
	<20051006201534.GX7992@ftp.linux.org.uk>
	<Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
	<20051009055549.GK7992@ftp.linux.org.uk>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro writes:
 > 	A bug had been caught in relayfs code -
 >         mem = vmap(buf->page_array, n_pages, GFP_KERNEL, PAGE_KERNEL);
 > in fs/relayfs/buffers.c is bogus (the third argument of vmap() is unrelated
 > to gfp flags).  s/GFP_KERNEL/VM_MAP/, presumably?  Author Cc'd, code in
 > question left alone for now.
 > 

Yes, looks like a stupid typo that luckily wasn't affecting the
outcome because the GFP_KERNEL value happens to not cause any false
test outcomes in the vmap code.  I'll submit a patch momentarily.

Thanks for catching this.

Tom



