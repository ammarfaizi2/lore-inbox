Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263245AbTDGE35 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 00:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbTDGE35 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 00:29:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:60386 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263245AbTDGE34 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 00:29:56 -0400
Message-ID: <3E910172.8030406@nortelnetworks.com>
Date: Mon, 07 Apr 2003 00:41:22 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: correct to set -nostdinc and then include <stdarg.h> ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was trying to compile 2.5.66 with gcc 3.2.2.  It dies as soon as it tries to 
compile init/main.c because it is unable to find "stdarg.h" which is included by 
"include/linux/kernel.h".

The "-nostdinc" flag is set in the compile options.  If I remove that flag, that 
particular file appears to compile fine.

It seems wrong to tell the compiler to not look in the standard places but then 
include a standard file.  Am I missing something?

Other compiler versions work fine, so I'm guessing the compiler now interprets 
the flag more strictly than before.

What is the proper way to deal with this?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

