Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbULHTGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbULHTGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbULHTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:06:50 -0500
Received: from mail.tmr.com ([216.238.38.203]:34571 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261315AbULHTGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:06:44 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Limiting program swap
Date: Wed, 08 Dec 2004 14:07:36 -0500
Organization: TMR Associates, Inc
Message-ID: <cp7iqj$57n$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1102532243 5367 192.168.12.100 (8 Dec 2004 18:57:23 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have several machine of various memory sizes which suffer from really 
poor performance when doing backups. This appears to be because all the 
programs other than the backup quickly get swapped to make room for i/o 
buffers.

Is there some standard portable way to prevent this, either by reserving 
some memory for programs which will not get swapped regardless of i/o 
pressure, or alternatively limiting the total memory used for i/o 
buffers, dcache, and similar things?

I did a crude hack for 2.4.17, but if I'm missing some obvious trick I'd 
rather not do something which can't go in the mainline kernel. Anyone 
care to show me what I missed, or is this just a characteristic of Linux?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
