Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUJAQRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUJAQRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUJAQRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 12:17:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56242 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264530AbUJAQQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 12:16:02 -0400
Subject: 2.6.9-rc2-mm4 ps hang ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1096646925.12861.50.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Oct 2004 09:08:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I randomly see "ps" hangs on my AMD64 system running 2.6.9-rc2-mm4.
I don't remember seeing this on earlier kernels. Is this something
known/fixed ?

Thanks,
Badari

Here are sysrq-t stacks:

ps            D ffffffff80132e3a     0 21006  11554               26798
(NOTLB)
0000010117609dc8 0000000000000006 0000000000000000 00000101d99cc530
       0000000200000089 000001019f49c8e0 000001019f49cc18
00000101b97351b0
       0000010199649250 ffffffff801b5ba3
Call Trace:<ffffffff801b5ba3>{pid_revalidate+131}
<ffffffff80445612>{__down_read+130}
       <ffffffff80142dda>{access_process_vm+74}
<ffffffff801b71fb>{proc_pid_cmdline+123}
       <ffffffff801b67ab>{proc_info_read+107}
<ffffffff80181284>{vfs_read+228}
       <ffffffff801813c3>{sys_read+83}
<ffffffff8011075e>{system_call+126}

ps            D 00000101770b1680     0 30632  30631         30633      
(NOTLB)
00000101dda8ddc8 0000000000000002 000000000000000c 00000101c1360030
       000000020000009f 00000101dda9d690 00000101dda9d9c8
0000000000000000
       00000101a0002ec0 00000101b97351b0
Call Trace:<ffffffff80445612>{__down_read+130}
<ffffffff80142dda>{access_process_vm+74}
       <ffffffff801b71fb>{proc_pid_cmdline+123}
<ffffffff801b67ab>{proc_info_read+107}
       <ffffffff80181284>{vfs_read+228} <ffffffff801813c3>{sys_read+83}
       <ffffffff8011075e>{system_call+126}

 

