Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUEALMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUEALMH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 07:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUEALMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 07:12:07 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:9384 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261317AbUEALMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 07:12:05 -0400
Message-ID: <40938618.1090100@mellanox.co.il>
Date: Sat, 01 May 2004 14:12:24 +0300
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: get_user_pages question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have been tryin to use get_user_pages() on malloced memory and get the 
list of pages but it does not work as
I expected:
1. malloc a buffer in user space
2. issue ioctl, invoke get_user_pages() and save the page descriptors I 
obtained.
3. at a later time, issue another ioctl, invoke get_user_pages() again 
and save another copy of the page descriptors.
4. Compare the two lists of page descriptors. They're not all the same.

Apparently some pages were discarded and the subsequent page fault 
brought a new page. I expected the original page to be in the swap cache 
and get the old page again. I repeated the experiment but before the 
first ioctl I wrote something to all the pages but got the same results. 
I used 2.4.21-4 (RH AS 3.0).

Can anyone clarify?
thanks
Eli
