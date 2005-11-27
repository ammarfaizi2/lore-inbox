Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVK0AjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVK0AjJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 19:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVK0AjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 19:39:09 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:17636 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750797AbVK0AjI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 19:39:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=j/MbGpZQ74VLs8EYYhF2H3xyboMpNT+sz6dLXF+wc9rMZCnlv0S3VctFhTTM18iwbcmAk4O1Uy/ktwvSYmJEgqK06dFykdfeJP3sNqILwIbmRkq6rCKJit0GujXbn1XiHfpn9/AQMixaryLiuCaa3WlZ8oDq6Lcqw3j5j874kUk=
Message-ID: <afd776760511261639k5ce77a97yfb744d3dc72a54ca@mail.gmail.com>
Date: Sat, 26 Nov 2005 18:39:07 -0600
From: Mohamed El Dawy <msdawy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Reading another process memory?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 How are you? I hope you are fine.

I am trying to write  a function that involves reading other processes
memory.
Here is what I can do

1. traverse the linked list of running processes searching for the
required pid
2. Follow the "mm" pointer to get the mm_struct
3. Traverse the "mmap" linked list in that mm_struct to get a list of
all ranges of addresses
3b. And read the "pgd" field too in the mm_sturct which contains the
page directory

Now, I have the page directory, and some logical addresses. Now comes
the tricky part, how can I actually read the memory? I am not really
sure how to read an address given a page directory and a logical
address. Do I need to translate it myself? Are there any functions to
do the job for me?

Thanks a lot in advacne
