Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262832AbULREJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbULREJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 23:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbULREJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 23:09:30 -0500
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:6092 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S262832AbULREIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 23:08:37 -0500
From: Russell Miller <rmiller@duskglow.com>
To: linux-kernel@vger.kernel.org
Subject: [slightly ot] ELF loader process
Date: Fri, 17 Dec 2004 22:12:56 -0600
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412172212.56546.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a question that isn't directly kernel related, but I can't seem to 
find a good forum to ask this question, so feel free to point me to a more 
appropriate place.  Also, this is pretty deep in the linux internals...

I'm trying to reverse engineer a trojan that some idiot left on a machine 
after cracking it.  I've run readelf.  It states that the entry point is:

  Entry point address:               0x804b06c

But that address seems to not be mapped anywhere in the executable.  There is:

  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x00406c 0x0804c06c 0x0804c06c 0x001d4 0x00338 RW  0x1000

which is exactly 0x1000 above the entry point address.  0x0804c06c is also the 
location of the _start symbol.

So, my question is (for any of you that will be willing to humor me and answer 
the question even though it's a little unrelated):  Why does the entry point 
address not match the _start symbol?  And if this is truly an error, what 
would happen if you tried to run the binary under linux?

Thanks.  You can feel free to email me privately with an answer if you don't 
want to post it here.

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Le Mars, IA
Duskglow Consulting - Helping companies just like you to succeed for ~ 10 yrs.
http://www.duskglow.com - 712-546-5886
