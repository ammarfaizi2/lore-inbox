Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVLAPdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVLAPdA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLAPdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:33:00 -0500
Received: from zrtps0kn.nortelnetworks.com ([47.140.192.55]:2009 "EHLO
	zrtps0kn.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932269AbVLAPdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:33:00 -0500
Message-ID: <438F179E.5040402@nortel.com>
Date: Thu, 01 Dec 2005 09:32:46 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: discrepency between "df" and "du" on tmpfs filesystem?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2005 15:32:48.0298 (UTC) FILETIME=[7BCF88A0:01C5F68C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Someone noticed this on one of our machines.  The rootfs is a 256MB 
tmpfs filesystem.  Depending on how you check the size, you get two 
different answers.


root@10.41.50.66:/root> df -hl
Filesystem            Size  Used Avail Use% Mounted on
rootfs                256M  250M  6.4M  98% /
none                   32M  116K   32M   1% /tmp

root@10.41.50.66:/root> df -kl
Filesystem           1K-blocks      Used Available Use% Mounted on
rootfs                  262144    255684      6460  98% /
none                     32768       116     32652   1% /tmp

root@10.41.50.66:/root> du -sxk /
204672  /

root@10.41.50.66:/root> du -sxh /
200M    /

Anyone know what's going on?

Chris
