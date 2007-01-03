Return-Path: <linux-kernel-owner+w=401wt.eu-S932132AbXACWBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbXACWBl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbXACWBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:01:41 -0500
Received: from smtp161.iad.emailsrvr.com ([207.97.245.161]:34122 "EHLO
	smtp161.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932132AbXACWBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:01:40 -0500
Message-ID: <459C2826.8040602@gentoo.org>
Date: Wed, 03 Jan 2007 17:03:18 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, a.p.zijlstra@chello.nl
Subject: Shared mmap'ed page writeback 2.6.18 backport
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Has anyone backported the recent shared mmap page writeback fix 
(7658cc289288b8ae7dd2c2224549a048431222b3) to 2.6.18 or previous?

It looks like there will be at least one more 2.6.18-stable release and 
I'd like to see it fixed there.

I don't know enough about the VM layer to understand this further, but 
the real "problem" in simply backporting the patch seems to be in this part:

+		if (page_mkclean(page))
+			set_page_dirty(page);

page_mkclean did not exist in 2.6.18. Is there a simple solution or 
should backporting the commit with added page_mkclean 
(d08b3851da41d0ee60851f2c75b118e1f7a5fc89) be considered instead? 
Hopefully that one has no other dependencies...

Thanks!
Daniel
