Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbTGTQmd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 12:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbTGTQmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 12:42:33 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:41425 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S267425AbTGTQmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 12:42:32 -0400
Message-ID: <3F1AC57B.6030005@myrealbox.com>
Date: Mon, 21 Jul 2003 00:38:19 +0800
From: Romit Dasgupta <romit@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Riley@Williams.Name, Dave Jones <davej@codemonkey.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Redundant cli ?? [arch/i386/boot/compressed/head.S]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     Looks like cli is done two times in arch/i386/boot/compressed/head.S.

The first occurence is in line number 33 just 2 lines after startup_32.
The second one is at line 103, just after the move_routine is moved to 
its rightful place and before transferring control to it. This looks 
like a redundant cli. The only place EFLAGS is directly touched is in 
line 53 (popfl) but that still has no effect on interrupt flag.

Please correct me if I am wrong, else the second cli may be removed.

Regards,
-Romit


