Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263032AbUGFFAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUGFFAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 01:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUGFFAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 01:00:30 -0400
Received: from [211.100.22.21] ([211.100.22.21]:6039 "EHLO nec.com.cn")
	by vger.kernel.org with ESMTP id S263032AbUGFFA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 01:00:28 -0400
Message-ID: <40EA325A.2060507@necas.nec.com.cn>
Date: Tue, 06 Jul 2004 13:02:18 +0800
From: lihg <lihg@necas.nec.com.cn>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; ja-JP; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to improve my dirver's performance
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have writen a driver as this :

1)a kernel thread receive data sent by other computer via tcp/ip, and
put them into a queue;
2)another kernel thread get the data from the queue ,and write it to a
disk .In this step,i implement by the follow code:

	......
	    generic_make_request(WRITE,bh);//the buffer head is alloced by
kmalloc by myself
            run_task_queue(&tq_disk);
   	......

My problem :
	In this way ,the disk's performance is bad.
	How can i do to improve the disk's performance ?
	Please give me a hand.





