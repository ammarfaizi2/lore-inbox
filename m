Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTDVTLR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbTDVTLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:11:17 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:23512 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263383AbTDVTLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:11:16 -0400
Date: Tue, 22 Apr 2003 15:19:27 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: IDE corruption during heavy bt878-induced interrupt load
To: joe briggs <jbriggs@briggsmedia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221523_MC3-1-3589-197B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am today replacing the IDE RAID with a 3WARE IDE-RAID that emulates SCSI on 
> the premise that the problem has to do with hardware bus arbitration.  But as 
> of yet I don't have any data to support that or show improvement.


  Did you use hdparm to enable unmaskirq and 32-bit IO on normal IDE?

  With lots of activity I find 8 sector IO to work better than 16,
and 32-bit IO with sync to be no slower than 32-bit IO without it, so
I put a line like this in /etc/rc.local for each disk on HPT370:

        hdparm -c 3 -u 1 -m 8 -a 8 /dev/hde

------
 Chuck
