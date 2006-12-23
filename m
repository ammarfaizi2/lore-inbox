Return-Path: <linux-kernel-owner+w=401wt.eu-S1753360AbWLWBVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbWLWBVv (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 20:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbWLWBVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 20:21:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:5977 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbWLWBVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 20:21:50 -0500
Message-ID: <5640c7e00612221721h1463aad2xf01c2785c6febce0@mail.gmail.com>
Date: Sat, 23 Dec 2006 14:21:48 +1300
From: "Ian McDonald" <ian.mcdonald@jandi.co.nz>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       sfrench@samba.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org, "Linus Torvalds" <torvalds@osdl.org>
Subject: [BUG] CIFS won't link
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fba2591bf4e418b6c3f9f8794c9dd8fe40ae7bd9
test_clear_page_dirty was removed a couple of days ago.

Now when I try and build I get this:
WARNING: "test_clear_page_dirty" [fs/cifs/cifs.ko] undefined!

This is caused by line 1248 of fs/cifs/file.c
			if (PageWriteback(page) ||
					!test_clear_page_dirty(page)) {

This isn't my area of expertise so I'm not providing a fix as I'm sure
I'll get it wrong!

My apologies if people have already fixed as I'm not on all the relevant lists.

Regards,

Ian
-- 
Web: http://wand.net.nz/~iam4
Blog: http://imcdnzl.blogspot.com
WAND Network Research Group
