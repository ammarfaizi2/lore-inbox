Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVCFLmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVCFLmU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 06:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVCFLmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 06:42:20 -0500
Received: from mailhub1.nextra.sk ([195.168.1.111]:41485 "EHLO
	mailhub1.nextra.sk") by vger.kernel.org with ESMTP id S261384AbVCFLmR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 06:42:17 -0500
Message-ID: <422AECBF.7040507@rainbow-software.org>
Date: Sun, 06 Mar 2005 12:42:55 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: domen@coderock.org
CC: emoenke@gwdg.de, linux-kernel@vger.kernel.org, nacc@us.ibm.com
Subject: Re: [patch 2/6] 12/34: cdrom/cdu31a: replace interruptible_sleep_on()
 with wait_event_interruptible()
References: <20050306103155.4AC7D1F202@trashy.coderock.org>
In-Reply-To: <20050306103155.4AC7D1F202@trashy.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
> Use wait_event_interruptible() instead of the deprecated
> interruptible_sleep_on(). The patch is straight-forward as the macros should 
> result in the same execution. Patch is compile-tested (still throws out warnings
> regarding {save,restore}_flags()).
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> Signed-off-by: Domen Puncer <domen@coderock.org>

I've posted a patch for the cdu31a driver some time ago that removes 
almost all usage of interruptible_sleep_on() and also 
{save,restore}_flags() - it uses semaphore instead.
The only remaining code is in sony_sleep() function when using 
IRQ-driven operation.

See http://lkml.org/lkml/2004/12/18/107
The patch is big because I've messed with the formatting...

-- 
Ondrej Zary
