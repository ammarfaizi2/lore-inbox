Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUIEQhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUIEQhU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUIEQhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:37:20 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:15624 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266880AbUIEQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:37:11 -0400
Message-ID: <413B40B3.1040009@steeleye.com>
Date: Sun, 05 Sep 2004 12:37:07 -0400
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: haiquy@yahoo.com
CC: linux-kernel@vger.kernel.org
Subject: Re: nbd questions and problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > It seems fine, but when the system touch swap there are error in the
 > kernel log
 >
 > nbd0 Receive control failed result -104
 >
 > and the server exited .

Well, -104 is Connection reset by peer. Nothing in nbd would cause that 
directly. Without seeing the error messages from the nbd-server it's 
hard to tell, but I suspect that either nbd-server is dying at startup 
(check the syslog on the server, a common cause is failure to open the 
file/partition) or you have some sort of networking issue. Can you 
otherwise communicate between the two systems over a TCP connection ?

--
Paul
