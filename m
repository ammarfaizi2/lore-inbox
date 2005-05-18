Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVERNu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVERNu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 09:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVERNtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 09:49:20 -0400
Received: from mxsf02.cluster1.charter.net ([209.225.28.202]:46258 "EHLO
	mxsf02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262193AbVERNsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:48:47 -0400
X-Ironport-AV: i="3.93,118,1115006400"; 
   d="scan'208"; a="813314377:sNHT50865570"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17035.18362.972972.148543@smtp.charter.net>
Date: Wed, 18 May 2005 09:48:42 -0400
From: "John Stoffel" <john@stoffel.org>
To: "Lincoln Dale \(ltd\)" <ltd@cisco.com>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: RE: Disk write cache (Was: Hyper-Threading Vulnerability)
In-Reply-To: <26A66BC731DAB741837AF6B2E29C10171E5590@xmb-hkg-413.apac.cisco.com>
References: <26A66BC731DAB741837AF6B2E29C10171E5590@xmb-hkg-413.apac.cisco.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Lincoln" == Lincoln Dale \(ltd\) <Lincoln> writes:

Lincoln> why don't drive vendors create firmware which reserved a
Lincoln> cache-sized (e.g. 2MB) hole of internal drive space somewhere
Lincoln> for such an event, and a "cache flush caused by hard-reset"
Lincoln> simply caused it to write the cache to a fixed (contiguous)
Lincoln> area of disk.

Well, if you're losing power in the next Xmilliseconds, do you have
the time to seek to the cache holding area and settle down the head
(since you could have done a seek from the edge of the disk to the
middle), start writing, etc?  Seems better to have a cache sized flash
ram instead where you could just keep the data there in case of power
loss.  

But that's expensive, and not something most people need...

John
