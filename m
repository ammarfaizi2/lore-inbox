Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbTDOPkK (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTDOPkK 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:40:10 -0400
Received: from dahlia.noc.ucla.edu ([169.232.46.11]:18707 "EHLO
	dahlia.noc.ucla.edu") by vger.kernel.org with ESMTP id S261700AbTDOPkG 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:40:06 -0400
Message-ID: <3E9C2A9C.2070005@ucla.edu>
Date: Tue, 15 Apr 2003 08:51:56 -0700
From: Benjamin Redelings I <bredelin@ucla.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.67: OOPS in wait_on_buffer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buffer layer error at fs/buffer.c:127
Call Trace:
  [<c014e780>] __wait_on_buffer+0xd0/0xe0
  [<c011ac00>] autoremove_wake_function+0x0/0x50
  [<c011ac00>] autoremove_wake_function+0x0/0x50
  [<c014ffd3>] unmap_underlying_metadata+0x23/0x70
  [<c0150527>] __block_prepare_write+0x117/0x440
  [<c0192bf8>] start_this_handle+0x98/0x1c0
  [<c0151034>] block_prepare_write+0x34/0x50
  [<c0185c00>] ext3_get_block+0x0/0xa0
  [<c0186252>] ext3_prepare_write+0x92/0x1b0
  [<c0185c00>] ext3_get_block+0x0/0xa0
  [<c0134f39>] generic_file_aio_write_nolock+0x349/0x9e0
  [<c0199f05>] journal_add_journal_head+0x45/0x150
  [<c0111b26>] convert_fxsr_to_user+0xc6/0x160
  [<c01356e1>] generic_file_aio_write+0x71/0x90
  [<c01837f4>] ext3_file_write+0x44/0xe0
  [<c014d3fb>] do_sync_write+0x8b/0xc0
  [<c01193bb>] schedule+0x19b/0x3a0
  [<d081e180>] unix_stream_ops+0x0/0x60 [unix]
  [<c0213209>] sock_poll+0x29/0x40
  [<c015f9ff>] do_pollfd+0x4f/0x90
  [<c015faaa>] do_poll+0x6a/0xd0
  [<c015f09a>] poll_freewait+0x3a/0x50
  [<c014d4ec>] vfs_write+0xbc/0x130
  [<c014d5fe>] sys_write+0x3e/0x60
  [<c010ab77>] syscall_call+0x7/0xb

System is AMD 1700+ XP, root is ext3.

I don't think I was doing anything special, but this might have happened 
when I tried to play a sound file using ALSA.

-BenRI
-- 
"I will begin again" - U2, 'New Year's Day'
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/

