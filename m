Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265719AbTF3Aiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 20:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbTF3Aiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 20:38:46 -0400
Received: from mx1.it.wmich.edu ([141.218.1.89]:54163 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265719AbTF3Aip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 20:38:45 -0400
Message-ID: <3EFF89EF.8050006@wmich.edu>
Date: Sun, 29 Jun 2003 20:53:03 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030628
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.73-mm2 ftp conntrack/nat not working
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, people access the ftp server with passive mode. This worked 
with my previous kernel on the router, 2.4.18. After updating, the box 
seems to miss the last packet(s) from the ftp server or client when 
finishing a transfer, such as a list or changing directory when using 
passive mode. I'm fairly sure it is a problem in one or both of the 
netfilter ftp modules because when not DNAT'ing the packets (ie. when 
accessing the server from the router itself) everything works as 
expected.  I'm not aware of any netfilter patches in the mm2 patchset so 
i think this is also a problem with the stock 2.5.73 release.  Can 
anyone else verify the problem or have experience with something 
similar.  Active mode seems to bypass the problem, further suggesting 
the netfilter modules i think?

