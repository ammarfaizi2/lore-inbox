Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWGJK5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWGJK5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 06:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWGJK5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 06:57:38 -0400
Received: from gateway-1237.mvista.com ([63.81.120.155]:57634 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S964777AbWGJK5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 06:57:37 -0400
Message-ID: <44B23256.8030504@ru.mvista.com>
Date: Mon, 10 Jul 2006 14:56:22 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, juha.yrjola@solidboot.com,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
       jlavi@iki.fi
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup() static
References: <20060626220215.GI23314@stusta.de>	<1151416141.17609.140.camel@hades.cambridge.redhat.com>	<20060629173206.GF19712@stusta.de> <1152436332.25567.12.camel@shinybook.infradead.org>
In-Reply-To: <1152436332.25567.12.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

David Woodhouse wrote:

>>>>This patch makes the needlessly global mtdpart_setup() static.

>>>>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>>>
>>>>--- linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c.old 2006-06-26 23:18:39.000000000 +0200
>>>>+++ linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c     2006-06-26 23:18:51.000000000 +0200
>>>>@@ -346,7 +346,7 @@
>>>>  *
>>>>  * This function needs to be visible for bootloaders.
>>>>  */
>>>>-int mtdpart_setup(char *s)
>>>>+static int mtdpart_setup(char *s) 

>>>Patch lacks sufficient explanation. Explain the relevance of the comment
>>>immediately above the function declaration, in the context of your
>>>patch. Explain your decision to change the behaviour, but not change the
>>>comment itself.

>>My explanation regarding the relevance of the comment is that it seems 
>>to be nonsense.

>>Do I miss something, or why and how should a bootloader access 
>>in-kernel functions? 

> I'm not entirely sure, but allegedly it does -- Juha, can you elaborate?

    In addition, this function might be needed to support parsing of the 
partition info extracted from the OF device tree (if this way of storing it 
there will be accepted)...

WBR, Sergei
