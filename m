Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVDEHrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVDEHrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 03:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVDEHqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:46:37 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.24]:31052 "EHLO smtp7.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261615AbVDEHkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:40:49 -0400
X-ME-UUID: 20050405074043788.C08D410000A1@mwinf0703.wanadoo.fr
Message-ID: <425240A2.6020504@innova-card.com>
Date: Tue, 05 Apr 2005 09:39:14 +0200
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BOOTMEM] bad physical address convertions.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm porting linux on an embedded system based on MIPS proc. I've 
encountered several
problems and one of these is related to the physical memory which 
doesn't start to 0.
This is actually not a big issue if code that makes physical address 
convertions uses the
appropriate macros that do the job.
Unfortunately there are some places in linux where this is not the case.
"bootmem.c" is one of these places. For instance, it does "addr >> 
PAGE_SHIFT"
instead of using "phys_to_pfn" macro in order to convert a physical 
address into a page
frame number.

Are there any interests for a patch which will fix that ?

Regards,

          Franck.

