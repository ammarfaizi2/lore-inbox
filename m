Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTE2TqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 15:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTE2TqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 15:46:21 -0400
Received: from minmail.no ([213.160.234.15]:23777 "EHLO new.minmail.no")
	by vger.kernel.org with ESMTP id S262577AbTE2TqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 15:46:19 -0400
From: Morten Helgesen <morten.helgesen@nextframe.net>
Reply-To: morten.helgesen@nextframe.net
Organization: Nextframe AS
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: list_head debugging patch
Date: Thu, 29 May 2003 21:58:52 +0200
User-Agent: KMail/1.5
References: <20030529130807.GH19818@holomorphy.com>
In-Reply-To: <20030529130807.GH19818@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305292158.52311.morten.helgesen@nextframe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one more ... 

elem = c3a6464c, elem->prev = c11d59e8, elem->prev->next = c28cc1ec
------------[ cut here ]------------
kernel BUG at include/linux/list.h:39!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c016b21c>]    Not tainted
EFLAGS: 00010286
EIP is at file_kill+0x2c/0x150
eax: 00000047   ebx: c3a6464c   ecx: c39f8d20   edx: c340a000
esi: c01b3ef0   edi: c3ff7d64   ebp: c340bf54   esp: c340bf3c
ds: 007b   es: 007b   ss: 0068
Process fixdep (pid: 2404, threadinfo=c340a000 task=c1166710)
 Stack: c03d5f20 c3a6464c c11d59e8 c28cc1ec c3a6464c c01b3ef0 c340bf78 
c016adf2
        c3a6464c c3a6464c c099c490 c09995e4 c3a6464c 00000000 00000000 
c340bf98
        c0169223 c3a6464c c21841f4 c001d364 c21841f4 00000004 c340a000 
c340bfbc
 Call Trace:
  [<c01b3ef0>] ext3_release_file+0x0/0x60
  [<c016adf2>] __fput+0xc2/0x140
  [<c0169223>] filp_close+0xd3/0x130
  [<c0169310>] sys_close+0x90/0x110
  [<c0109bdf>] syscall_call+0x7/0xb

Code: 0f 0b 27 00 95 42 3d c0 8b 13 8b 42 04 39 d8 74 22 89 44 24

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
morten.helgesen@nextframe.net / 93445641
http://www.nextframe.net

