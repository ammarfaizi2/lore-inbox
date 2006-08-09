Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030563AbWHIHRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbWHIHRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 03:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbWHIHRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 03:17:42 -0400
Received: from 62-90-3-11.barak.net.il ([62.90.3.11]:56200 "EHLO zeus.scalemp")
	by vger.kernel.org with ESMTP id S1030563AbWHIHRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 03:17:41 -0400
Message-ID: <44D98BF3.5060706@scalemp.com>
Date: Wed, 09 Aug 2006 10:17:07 +0300
From: sasha <sasha@scalemp.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Map memory to user, then map it back to kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.

I am looking for a way to map a memory (allocated with get_free_pages()) 
from kernel space to user space, so that I will later be able to map it 
back with get_user_pages().

I tried remap_pfn_range(), but it didn't work as it assumes the memory 
being mapped is IO range (marking vma with VM_IO flag), while 
get_user_pages() works on regular memory.

Any ideas?

Thanks.
Alexander Sandler.

PS: Please CC to me.
