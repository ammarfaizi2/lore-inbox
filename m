Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVLESBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVLESBo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVLESBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:01:43 -0500
Received: from web34114.mail.mud.yahoo.com ([66.163.178.112]:7821 "HELO
	web34114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932491AbVLESBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:01:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iItOq05BoO/BjN/GBLkhKRvuBQRwGnvDOXsZP/0mB/0b86BLcG9gLtKEAmwPjHZ8sDQl5fE7TEM1za1/Y525aXHVekhZD3RnLywxJnRHdMT3Apc/AyVhG33Y3RKOqQswn0BowCbJywy/lZ6UHZIdQpEvxb7mT3svjUSe06c3BPQ=  ;
Message-ID: <20051205180139.64009.qmail@web34114.mail.mud.yahoo.com>
Date: Mon, 5 Dec 2005 10:01:39 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Kenny Simpson <theonetruekenny@yahoo.com>, linux-kernel@vger.kernel.org
Cc: theonetruekenny@yahoo.com
In-Reply-To: <20051130200448.76281.qmail@web34103.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested with rc5 - same results.  It was suggested that I run slabtop when the system freezed, so
here is that info: (again, by hand, I'm getting another machine to use either netconsole or a
serial cable).

 Active / Total Objects (% used)    : 478764 / 485383 (98.6%)
 Active / Total Slabs (% used)      : 14618 / 14635 (99.9%)
 Active / Total Caches (% used)     : 79 / 138 (57.2%)
 Active / Total Size (% used)       : 56663.79K / 57566.41K (98.4%)
 Minimum / Average / Maximum Object : 0.01K / 0.12K / 128.00K

  OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME                   
403088 403088 100%    0.06K   6832       59     27328K nfs_page
 30380  30380 100%    0.50K   4340        7     17360K nfs_write_data
 15134  15134 100%    0.27K   1081       14      4324K radix_tree_node
...


The other thing is that the stack trace showsd slabtop as being halted in throttle_vm_writeout
while allocating memory, and the writetest was halted waiting to allocate memory.

I'll get more detailed stack traces once I get the second machine set up.

-Kenny



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
