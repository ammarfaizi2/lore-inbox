Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUE2ICT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUE2ICT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUE2ICT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:02:19 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:62597 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263885AbUE2ICO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:02:14 -0400
Message-ID: <40B84065.3000106@linuxmail.org>
Date: Sat, 29 May 2004 17:48:53 +1000
From: Nigel Cunningham <ncunningham@linuxmail.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Rob Landley <rob@landley.net>, seife@suse.de, linux-kernel@vger.kernel.org,
       Suspend list <swsusp-devel@lists.sourceforge.net>
Subject: Re: swappiness=0 makes software suspend fail.
References: <200405280000.56742.rob@landley.net> <20040528215642.GA927@elf.ucw.cz>
In-Reply-To: <20040528215642.GA927@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Pavel Machek wrote:
>>With swappiness at the default (60), software suspend frees all the memory it 
>>needs.  With swappiness at 0, software suspend basically doesn't free any 
>>memory, and the suspend gets aborted.
>>
>>Just thought I'd mention it.  Tried on 2.6.6...
> 
> 
> Uh, yes, right.
> 
> That explains why some people see bad problems I could not
> reproduce. Thanks a lot.
> 
> Stefan, we may want to do echo 100 > /proc/sys/vm/swappiness in
> suspend script...
> 
> 									Pavel

This applies to suspend2 for 2.6 as well. I recently changed to using the same routines to free memory.

Nigel


-- 
Nigel & Michelle Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6254 0216 (home)

After homosexuality, they'll be arguing paedophilia is normal.
