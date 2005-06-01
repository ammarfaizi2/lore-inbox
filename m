Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVFASzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVFASzV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVFASxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:53:13 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:10388 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261214AbVFAShK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:37:10 -0400
Subject: 2.6.12-rc5-mm2 mkdir hangs on JFS ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, shaggy@us.ibm.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1117647033.26913.1589.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2005 11:16:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Shaggy,

I ran into "mkdir" hang on JFS on 2.6.12-rc5-mm2, while I was
trying to kill my tests. Doesn't really look like a JFS
issue to me.

Any signal handling related changes happened in -mm2 ?

Thanks,
Badari

mkdir         T 0000000000000013     0 20869      1               19654
(NOTLB)
ffff8101c912dde8 0000000000000082 0000000000000011 ffff810100040005
       0000000000005185 ffff810100000013 0000000200000000
ffff8101bc910930
       0000000000000611 ffff8101c16420d0
Call Trace:<ffffffff801407d5>{__dequeue_signal+501}
<ffffffff80141c62>{finish_stop+146}
       <ffffffff801430cb>{get_signal_to_deliver+1323}
<ffffffff8010d072>{do_signal+162}
       <ffffffff801952ef>{sys_mkdir+239}
<ffffffff8010dca7>{sysret_signal+28}
       <ffffffff8010df8f>{ptregscall_common+103}


