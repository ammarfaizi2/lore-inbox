Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTDFPUJ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263010AbTDFPUJ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:20:09 -0400
Received: from siaag2ac.compuserve.com ([149.174.40.133]:8376 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S263009AbTDFPUI (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:20:08 -0400
Date: Sun, 6 Apr 2003 11:29:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: tuning disk on 3ware /performance problem
To: Stephan van Hienen <raid@a2000.nu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304061131_MC3-1-333A-E630@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> Is there anything i can do to tune the drives connected to he 3ware
> controller ? (37MB/sec vs 43MB/sec) (and why is the seq. output block
> 65MB/sec on the 3ware vs 41MB/sec on 'ide controllers')


Try doing a real test with a 1 GB file on an empty filesystem:


# mount /fs && date
# time dd if=/dev/zero of=/fs/file1 bs=128k count=8k
# umount /fs && date && mount /fs
# time dd if=/fs/file1 of=/dev/null bs=128k


I get numbers that disagree with hdparm by a large amount.

--
 Chuck
 I am not a number!
