Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263855AbTD0JDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 05:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263863AbTD0JDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 05:03:38 -0400
Received: from webbox110.server-home.net ([62.208.70.32]:7297 "EHLO
	webbox110.server-home.net") by vger.kernel.org with ESMTP
	id S263855AbTD0JDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 05:03:20 -0400
Message-ID: <3EABA03B.9070309@informatik.uni-wuerzburg.de>
Date: Sun, 27 Apr 2003 11:17:47 +0200
From: Per Pascal Grube <pgrube@informatik.uni-wuerzburg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030422
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] Probably ext3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

My system could not access the filesystem anymore for writting after the 
following message appeared in the syslog. Unmount also didn't work anymore.

Apr 27 01:09:01 cybercom kernel:  kernel BUG at buffer.c:509!
Apr 27 01:09:01 cybercom kernel: invalid operand: 0000
Apr 27 01:09:01 cybercom kernel: CPU:    0
Apr 27 01:09:01 cybercom kernel: EIP: 
0010:[__insert_into_lru_list+30/96]
Tainted: P
Apr 27 01:09:01 cybercom kernel: EFLAGS: 00010282
Apr 27 01:09:01 cybercom kernel: eax: f4392d40   ebx: 00000002   ecx: 
da6076c0
  edx: c03cefac
Apr 27 01:09:01 cybercom kernel: esi: da6076c0   edi: 00000001   ebp: 
da6076c0
  esp: d1ad5e7c
Apr 27 01:09:01 cybercom kernel: ds: 0018   es: 0018   ss: 0018
Apr 27 01:09:01 cybercom kernel: Process bzip2 (pid: 687, 
stackpage=d1ad5000)
Apr 27 01:09:01 cybercom kernel: Stack: 00000002 c013ca58 da6076c0 
00000002 da60
76c0 00001000 c013d582 da6076c0
Apr 27 01:09:01 cybercom kernel:        00001000 00000000 09758000 
00000000 c20e
4580 ca22c740 c013dd4f ca22c740
Apr 27 01:09:01 cybercom kernel:        c20e4580 00000000 00001000 
c20e4580 ca22
c740 c20e4580 00001000 c0163d3c
Apr 27 01:09:01 cybercom kernel: Call Trace:    [__refile_buffer+88/112] 
[__bloc
k_commit_write+178/208] [generic_commit_write+63/160] 
[ext3_commit_write+348/672
] [journal_dirty_sync_data+0/160]
Apr 27 01:09:01 cybercom kernel:   [generic_file_write+1127/1952] 
[ext3_file_wri
te+57/208] [sys_write+163/304] [system_call+51/56]
Apr 27 01:09:01 cybercom kernel:
Apr 27 01:09:01 cybercom kernel: Code: 0f 0b fd 01 57 f8 2f c0 8b 02 85 
c0 75 07
  89 0a 89 49 24 8b

