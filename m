Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275655AbTHOCRM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275654AbTHOCRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:17:12 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:23424 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S275655AbTHOCRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:17:11 -0400
Date: Thu, 14 Aug 2003 21:17:07 -0500
From: mouschi@wi.rr.com
Subject: Interesting VM feature?
To: linux-kernel@vger.kernel.org
Reply-to: mouschi@wi.rr.com
Message-id: <13dedd139cb9.139cb913dedd@rdc-kc.rr.com>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.12 (built Feb 13 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC: me,)

Hi,

I've recently come across someone porting some code
from windows that trys to implement an efficient
memory pool using some VM tricks. I have no idea if
linux has an equivalent to this feature (described
below), and wouldn't know what to even search for to
find out.

What this mempool wants to do is to be able to
allocate a block of memory and tell the kernel which
pages from it can be outright discarded, instead of
swapped out when memory starts to get crowded. 

Now, from looking at mel's docs, it looks to me like
this would mean letting the application directly
mark pages clean. But it would also mean finding any
swapped out versions of this page and deallocating
them, otherwise if the page is discarded and then
used again, time would be wasted swapping in garbage.

I'm going to keep reading. If this is already
implemented, or if the efficiency gains would be
nil, somebody yell at me before I start crashing my
kernel with attempts at doing this myself. :-) It
seems so trivial after all...

Thanks,
Ted Kaminski

