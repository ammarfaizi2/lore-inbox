Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261419AbVB0Qxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbVB0Qxq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 11:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbVB0Qxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 11:53:46 -0500
Received: from www.rapidforum.com ([80.237.244.2]:18150 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261419AbVB0Qxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 11:53:45 -0500
Message-ID: <4221FB13.6090908@rapidforum.com>
Date: Sun, 27 Feb 2005 17:53:39 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Slowdown on high-load machines with 3000 sockets
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

The problem here is that starting with 3000 sockets, the syswrite locks more and more on the sockets 
although the sockets are non-blocking. This just suddenly appears at around 3000 sockets. I have 
raised min_free_kbytes to 1024000 and then it suddenly did not block anymore. I changed it down to 
16000 again and id instantly locked again. Up to 1024000 and no locking. Now it starts blocking 
again at 4000 sockets even with 1024000 min_free_kbytes, slowing everything down.... what could this 
be? Its no network-problem. I have discussed this issue with netdev-people for 2 weeks. No memory 
problem as well I suppose, its 8 gb ram with a 2/2 split...

This problem has been observed on a 2.6.10 kernel.

Please help. Thank you in advance.


Best regards,
Chris
