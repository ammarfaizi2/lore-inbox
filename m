Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbTCGX6H>; Fri, 7 Mar 2003 18:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261955AbTCGX6H>; Fri, 7 Mar 2003 18:58:07 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:20185 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261945AbTCGX6C>; Fri, 7 Mar 2003 18:58:02 -0500
Date: Fri, 07 Mar 2003 15:59:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 450] New: PPP (PPPoE) causes OOPS on interface initialization, 2.5.64
Message-ID: <1780000.1047081546@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=450

           Summary: PPP (PPPoE) causes OOPS on interface initialization,
                    2.5.64
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: david+bugme.osdl.org@blue-labs.org


Distribution: 
Hardware Environment: VT82C693A, Pentium III (Coppermine)
Software Environment: firewall running ipchains
Problem Description: pppd generates an OOPS on machine startup when pppX is
initialized

Steps to reproduce: bring up pppX (ppp0-n) with pppoe plugin.

Unable to handle kernel NULL pointer dereference at virtual address 00000005
printing eip:
c030eee6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c030eee6>]    Not tainted
EFLAGS: 00010202
EIP is at packet_dev_mclist+0x16/0x38
eax: 00000005   ebx: 00000001   ecx: 00002710   edx: 00000000
esi: cbcfb400   edi: 00000001   ebp: cad51e54   esp: cad51e48
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 268, threadinfo=cad50000 task=cba45320)
Stack: cbd1e964 cbfcf59c cbcfb400 cad51e74 c030f7bd cbcfb400 00000001 00000001
      c03edc14 cbcfb400 00000001 cad51e94 c012aa27 c03edc14 00000001 cbcfb400
      cbcfb400 00000000 00001090 cad51eb8 c02ac6d6 c048bcc4 00000001 cbcfb400
Call Trace:
[<c030f7bd>] packet_notifier+0x28d/0x2a8
[<c012aa27>] notifier_call_chain+0x23/0x40
[<c02ac6d6>] dev_open+0xb6/0xc4
[<c02adc71>] dev_change_flags+0x59/0x110
[<c02e61e4>] devinet_ioctl+0x2c4/0x5cc
[<c02e9047>] inet_ioctl+0xb3/0xf4
[<c02a5ab1>] sock_ioctl+0x1cd/0x1dc
[<c016779f>] sys_ioctl+0x1ef/0x210
[<c0109777>] syscall_call+0x7/0xb

Code: 39 43 04 75 0b 57 53 56 e8 6d ff ff ff 83 c4 0c 8b 1b 85 db


