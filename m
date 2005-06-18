Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFRCxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFRCxP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 22:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFRCxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 22:53:15 -0400
Received: from web61215.mail.yahoo.com ([209.73.179.64]:1466 "HELO
	web61215.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261258AbVFRCxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 22:53:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xOR3BuFtVkqY7LQJ+OusRmtZdIX96L1I1sMnWk6MUrmZjBZI3OyKcHn9QRPgJMfviR60ZLPjYkbyeMfbq1I/WLMI8JxeId0GheNTOHukapRVuLfALICilyNA7tgwIxXAaud1dxvCwE5H3NhVyj/VgtmEjerGv3re+y7rLZCd8Dw=  ;
Message-ID: <20050618025312.22719.qmail@web61215.mail.yahoo.com>
Date: Fri, 17 Jun 2005 19:53:12 -0700 (PDT)
From: movq movq <movq_64@yahoo.com>
Subject: missing kfree in fs/ext3/balloc.c
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first post, so be kind. Perhaps I am wrong
here, but I was looking through fs/ext3/balloc.c and
noticed this line:

line 268
...
block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
...

But I do not see this chunk of memory ever kfree()'d.
Is there a reason for this or is this kfree() just
missing?

- Thanks

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
