Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVEPCcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVEPCcF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 22:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVEPCcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 22:32:05 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:61959 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261248AbVEPCcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 22:32:03 -0400
Message-ID: <42880620.8000300@rtr.ca>
Date: Sun, 15 May 2005 22:32:00 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
References: <1115963481.1723.3.camel@alderaan.trey.hu> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <200505152156.18194.gene.heskett@verizon.net>
In-Reply-To: <200505152156.18194.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >took place on another list, and wrote a test gizmo that copied a
 >large file, then slept for 1 second and issued a sync command.  No
 >drive led activity until the usual 5 second delay of the filesystem
 >had expired.  To me, that indicated that the sync command was being

There's your clue.  The drive LEDs normally reflect activity
over the ATA bus (the cable!). If they're not on, then the drive
isn't receiving data/commands from the host.

Cheers
