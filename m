Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbTGBXbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 19:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbTGBXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 19:31:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:45225 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265943AbTGBXb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 19:31:28 -0400
Subject: Re: Linux 2.5.74: BUG at mm/slab.c:1537
From: Andy Pfiffer <andyp@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307021433520.2323-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057189512.1305.3.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 02 Jul 2003 16:45:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.74 booted okay, but after I "init 1", it BUG's (whitespace mangled):

Shutting down zope                                                  
done
Shutting down RPC portmap daemon                                    
done
Shutting down SSH daemonkfree_debugcheck: out of range ptr 100h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:1537!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01457ad>]    Not tainted
EFLAGS: 00010002
EIP is at kfree+0x35/0x268
eax: 0000002c   ebx: ded59b68   ecx: c150bc20   edx: c0412ce8
esi: 00000100   edi: 00040000   ebp: df12df30   esp: df12df00
ds: 007b   es: 007b   ss: 0068
Process netstat (pid: 1405, threadinfo=df12c000 task=df3c6080)
Stack: c0389060 00000100 ded59b68 df5e0e64 df0b4cb4 df12df6c df5e0e84
df12df30 
       c0344ca1 ded59b68 00000001 00000206 df12df48 c017ae8c 00000100
defe1c54 
       df5e0e64 df0b4cb4 df12df6c c015b9c7 df0b4cb4 df5e0e64 defe1c54
df5e0e64 
Call Trace:
 [<c0344ca1>] raw_seq_start+0x4d/0x58
 [<c017ae8c>] seq_release_private+0x18/0x30
 [<c015b9c7>] __fput+0x3b/0xfc
 [<c015b987>] fput+0x17/0x1c
 [<c015a402>] filp_close+0x10a/0x118
 [<c015a4ba>] sys_close+0xaa/0x100
 [<c010af6f>] syscall_call+0x7/0xb

Code: 0f 0b 01 06 27 8d 38 c0 83 c4 08 8d 04 bf c1 e0 03 89 45 f8 
                                                                    
done
Shutting down syslog services                                       
failed
Shutting down network interfaces:
    eth0                                                            
done
Shutting down personal-firewall [not active]                        
unused
Saving random seed                                                  
done
Loading keymap qwerty/us.map.gz                                     
done
Loading console font lat1-16.psfu                                   
done
Loading screenmap none                                              
done
Setting up console ttys




