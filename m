Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270060AbTGNKyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 06:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270063AbTGNKyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 06:54:51 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:55673 "EHLO
	corp.tivoli.com") by vger.kernel.org with ESMTP id S270060AbTGNKyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 06:54:50 -0400
Message-ID: <3F128F6C.5000106@tiscalinet.it>
Date: Mon, 14 Jul 2003 13:09:32 +0200
From: "Salvatore D'Angelo" <koala.gnu@tiscalinet.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: boot process on i386
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am looking at the boot code in bootsect.S and I have some doubt. I 
tried to search the answers to my questions on marc.theaimsgroup.com and 
on google bu I haven't found them.

Problably these are newbie question but I'll appreciate if someone of 
you help me.

1) In the bootsect code the first thing that is done is to copy the boot 
sector to 0x90000 and move the program count to 0x9000, go.
Why it is necessary move the code there? is It not possible continue the 
process from 0x7C00?

2) Another step is to move the parameters table from 0x78:0 to 
0x9000:0x4000-12. WHat are
the info contained in this table? Can you send me a link to a site that 
specify these info?
Withouth these info I am not able to understand these three line of code

        movb    $36, 0x4(%di)           # patch sector count
        movw    %di, %fs:(%bx)
        movw    %es, %fs:2(%bx)

Thanks in advance for your help



