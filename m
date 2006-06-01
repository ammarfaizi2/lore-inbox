Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965223AbWFAR2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965223AbWFAR2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 13:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWFAR2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 13:28:40 -0400
Received: from gw.goop.org ([64.81.55.164]:55009 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965223AbWFAR2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 13:28:39 -0400
Message-ID: <447F23C2.8030802@goop.org>
Date: Thu, 01 Jun 2006 10:28:34 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: State of resume for AHCI?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I'm trying to get a Thinkpad X60 working properly.  My biggest remaining 
problem is the failure of AHCI to resume properly after suspend-to-ram.  
I know the problem is known about and there are patches floating about 
to address it, but I don't really understand the larger picture.  There 
were some discussions about it a couple of months ago, but I haven't 
seen anything much since.

Is there a git tree which should work properly on this hardware, or a 
current patch to do it?  Does somebody need to bring the existing patch 
up to date?  Does fixing this require more infrastructure changes which 
are still brewing?

I'm running 2.6.17-rc2-mm1 (soon mm2).  I've tried porting Hannes 
Reinecke's patch to this tree, but there have been some code changes 
which cause significant conflicts, and I don't really know enough about 
the driver/hardware to be confident in my changes.  That said, I have 
got something compiling, but it crashes somewhere in the kobject stuff 
when it encounters the first port with no drive on it; this looks like a 
more general scsi/libata bug; I'll track it down if its interesting.

Anyway, I'd appreciate it if you could give me some hints about how to 
get a fix with some current kernel.

Thanks,
    J
