Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbTFSTLZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTFSTLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:11:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60291 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265908AbTFSTLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:11:22 -0400
Message-ID: <3EF20E86.3030102@austin.ibm.com>
Date: Thu, 19 Jun 2003 14:27:02 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 umount hangs
References: <3EF1EC73.4070305@austin.ibm.com> <20030619105817.51613df2.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>Has anyone else seen hangs trying to umount ext3 volumes?
>>    
>>
>Could you please debug it a bit?  sysrq-T, etc?
>
Here is the trace of the hung process:

umount        D 00000001 290213268 18747  18746                     (NOTLB)
Call Trace:
 [<c01a1ae8>] journal_kill_thread+0xa8/0xe0
 [<c011c780>] default_wake_function+0x0/0x30
 [<c016d8c5>] destroy_inode+0x35/0x60
 [<c01a2b80>] journal_destroy+0x10/0x1c0
 [<c019a97e>] ext3_xattr_put_super+0x1e/0x30
 [<c0196209>] ext3_put_super+0x29/0x1a0
 [<c015b64b>] generic_shutdown_super+0x16b/0x180
 [<c015c03d>] kill_block_super+0x1d/0x50
 [<c015b3fd>] deactivate_super+0x5d/0x90
 [<c0170fef>] sys_umount+0x3f/0xa0
 [<c0171067>] sys_oldumount+0x17/0x20
 [<c010afaf>] syscall_call+0x7/0xb


Here is a link to the console log with full sysrq trace:

http://www-124.ibm.com/developerworks/opensource/linuxperf/logs/ext3umount

Steve

