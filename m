Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVJZFG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVJZFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 01:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVJZFG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 01:06:28 -0400
Received: from web35602.mail.mud.yahoo.com ([66.163.179.141]:6761 "HELO
	web35602.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932542AbVJZFG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 01:06:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JKyGI7HtE2BiIMj3fc4ZT89FUQbEnd0Fm3Yck0Ty8IB7uy9NfsWFVscc1J3ssFlfDcUfcgdy+ac+F5z7WsRESzK3Ikg0QIBylAfrIR0sK7jgVvZH714QXYgjvBr6hMwqCxPZYSYjrPAH1bjuR1vJjSL415fa+qf3t6rYlhiUCCw=  ;
Message-ID: <20051026050627.69339.qmail@web35602.mail.mud.yahoo.com>
Date: Tue, 25 Oct 2005 22:06:27 -0700 (PDT)
From: salve vandana <vandanasalve@yahoo.com>
Subject: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051026024831.GB17191@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting this VM error on 2.4.28kernel(RAM-768MB,
No Swap and the root file system,whose size is around
300MB is loaded as initrd).
After the error the processes are getting killed and
system is rebooted. I am not understanding why the MM
is trying is allocate pages from HIGH Memory
(gfp=0x1d2/0) when I dont have High memory and the
kernel is also not enabled to support High memory. I
have put the printk's to see how kswapd is woken up to
free unused pages because I dont want to run out of
memory.

Here is log:

try_to_free_pages_zone
try_to_free_pages_zone
try_to_free_pages_zone
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
VM: killing process cp_test
Received SIGCHLDtry_to_free_pages_zone
cp_test exited (PID = 213).Invalid TFTP URL for
exporting crash-dumps...
__alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
ry_to_free_pages_zone
try_to_free_pages_zone
try_to_free_pages_zone

Thanks,
Vandana




		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
