Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbUKJUVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbUKJUVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbUKJUVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:21:49 -0500
Received: from mail.tmr.com ([216.238.38.203]:48907 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262034AbUKJUVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:21:48 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: mmap vs. O_DIRECT
Date: Tue, 09 Nov 2004 19:05:13 -0500
Organization: TMR Associates, Inc
Message-ID: <cmtsoo$j55$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1100117593 19621 192.168.12.100 (10 Nov 2004 20:13:13 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an application which does a lot of mmap to process its data. The 
huge waitio time makes me think that mmap isn't doing direct i/o even 
when things are alligned. Before I start poking the code, is there a 
reason why direct is not default for i/o in page-size transfers on page 
size file offsets? I don't have source code, but the parameters of the 
mmap all seem to satisfy the allignment requirements.

I realize there may be a reason for forcing the i/o through kernel 
buffers, or for not taking advantage of doing direct i/o whenever 
possible, it just doesn't jump out at me.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
