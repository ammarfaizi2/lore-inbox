Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264031AbUDQUDm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbUDQUDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 16:03:42 -0400
Received: from picton.eecg.toronto.edu ([128.100.10.141]:39652 "EHLO
	picton.eecg.toronto.edu") by vger.kernel.org with ESMTP
	id S264031AbUDQUDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 16:03:41 -0400
Message-ID: <40818D9A.9030002@acm.org>
Date: Sat, 17 Apr 2004 16:03:38 -0400
From: Ashvin Goel <ashvin@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Question regarding do_tcp_sendpages, tcp_current_mss and eff_sacks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to use do_tcp_sendpages() to stream some data from within 
the Linux Redhat kernel 2.4.20 (it is an smp kernel running on a 
uniprocessor). After a while this function returns an error value of 
-512. This error value makes no sense to me. A little debugging showed 
that tcp_current_mss() returns negative values. In particular, for the 
socket to which do_tcp_sendpages() is sending data, tp->eff_sacks has 
the value 200. This makes the value returned by tcp_current_mss be -156 
(1448 - 4 - 200 * 8). Is this value reasonable? I think this value is 
causing do_tcp_sendpages() to return a large negative value.

Thanks for any help/suggestions. Please CC your post to me personally.

Thanks
Ashvin Goel
