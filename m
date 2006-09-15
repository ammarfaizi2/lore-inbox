Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWIOKWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWIOKWJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 06:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWIOKWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 06:22:09 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:51117 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750912AbWIOKWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 06:22:06 -0400
Message-ID: <450A7EC5.2090909@bull.net>
Date: Fri, 15 Sep 2006 12:21:57 +0200
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de, Matt_Domsch@dell.com
Subject: [Bug ??] 2.6.18-rc6-mm2 - PCI ethernet board does not seem to work
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/09/2006 12:27:47,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/09/2006 12:27:48,
	Serialize complete at 15/09/2006 12:27:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Ethernet board (Intel(R) PRO/1000) "doesn't seems" to work any more
with this kernel, but all is ok with kernel 2.6.18-rc6-mm1.

A bisection search show this patch:
gregkh-pci-pci-sort-device-lists-breadth-first.patch
as being the faulty one...

But after reading the content of this patch, I understood that the order
of the ethernet boards had changed. In fact,  I have four ethernet
boards and now, my eth0 does not point on the same card...
So all is now ok by changing my cable to the right board.

But is this really the expected behavior ?


-- 
Pierre Peiffer

