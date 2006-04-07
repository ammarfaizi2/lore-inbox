Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWDGSGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWDGSGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWDGSGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:06:05 -0400
Received: from dvhart.com ([64.146.134.43]:18376 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964839AbWDGSGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:06:04 -0400
Message-ID: <4436AA05.7020203@mbligh.org>
Date: Fri, 07 Apr 2006 11:05:57 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: wierd failures from -mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hadn't mailed this out for a while, cause we weren't sure if it was 
-mm or a testing glitch, but there's been no -git releases, so Andy 
reran -mm to double check, and it still seems to be there. a subsequent
test of rc1 + cons patches didn't hit this ... I think -mm has issues ;-)

Look at the 2.6.17-rc1-mm1 column from: http://test.kernel.org/

Drilling down into the console logs:

http://test.kernel.org/abat/27597/debug/console.log
Hangs after testing NMI watchdog.
http://test.kernel.org/abat/27596/debug/console.log
Hangs after bringing up cpus.

http://test.kernel.org/abat/27598/debug/console.log
http://test.kernel.org/abat/27593/debug/console.log
Both fail with reiserfs fsck errors; at first sight look like just dirty
root partitions, but I don't think they are.



Filesystem is clean
Failed to lock the process to fsck the mounted ro partition. Bad address.
fsck.reiserfs /dev/sda3 failed (status 0x8). Run manually!


Note that it's actually saying it's clean.
