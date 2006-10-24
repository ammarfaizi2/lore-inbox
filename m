Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWJXK6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWJXK6H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 06:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbWJXK6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 06:58:07 -0400
Received: from math.ut.ee ([193.40.36.2]:48358 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1030293AbWJXK6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 06:58:04 -0400
Date: Tue, 24 Oct 2006 13:58:01 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: reboot hang (e100 shutdown)
In-Reply-To: <Pine.SOC.4.61.0610231827490.3188@math.ut.ee>
Message-ID: <Pine.SOC.4.61.0610241355420.12615@math.ut.ee>
References: <Pine.SOC.4.61.0610231827490.3188@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Reboot hangs in yesterdays 2.6.19-rc2+git snapshot while 2.6.19-rc2 rebooted 
> fine. This is a P4 PC with Intel 845 chipset. The last message seen is (typed 
> from memory)
> Synchonizing dick cache for sda

The hang is still there in 2.6.19-rc3 but this time I remebered to try 
SysRq+T and it was worth it.

The hang happens in e100_shutdown calling schedule_timeout-interruptible
and this seems to be a known bug that has a fix floating around.

-- 
Meelis Roos (mroos@linux.ee)
