Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTDYUo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTDYUo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:44:28 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:43236 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S263971AbTDYUo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:44:26 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.5.68 fails (sometimes dies) with X/i830 graphic board
Date: Fri, 25 Apr 2003 22:56:36 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304252256.36970.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel sometime dies at exiting from X with CTRL-ALT-SUP. Sometimes it 
gives errors in the console, something related to mtrr and saying 
"Recovered, but we need to reboot" (sorry, couldn't copy/paste the 
message).

The PC is a Dell Latitude X200, i830M graphic board. DRI is enabled in the 
kernel, but not loaded by X (it works, but I commented it out in 
XF86Config).

In my last try to copy the message, I've got the following error when I 
started X:

agp_allocate_memory: d5c74d20
agp_allocate_memory: d5c74ce0
agp_allocate_memory: d5c74ca0
agp_allocate_memory: d5c74c60
agp_allocate_memory: d5c74ce0
agp_allocate_memory: d5c74ca0
agp_allocate_memory: d5c74c60
agp_allocate_memory: d74ba3e0
Unable to handle kernel paging request at virtual address d52fd000
 printing eip:
c013f49f
*pde = 150001e3
*pte = ffffff44
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c013f49f>]    Not tainted
EFLAGS: 00010287
eax: c02e696c   ebx: c134f788   ecx: 00000400   edx: 00001000
esi: d5c9f000   edi: d52fd000   ebp: c13678d8   esp: d606beb8
ds: 007b   es: 007b   ss: 0068
Process kdm (pid: 505, threadinfo=d606a000 task=d5c54720)
Stack: 000000d0 00000000 01f11014 c134f788 d5403a60 d6999bfc bfffe9d4 
d5d88e80
       00000001 c01404f9 d5d88e80 d6deabe0 bfffe9d4 d553cff8 d6999bfc 
15c9f065
       00000000 d5d88e80 d5d88ea0 d5c54720 bfffe9d4 c011696c d5d88e80 
d6deabe0
Call Trace: [<c01404f9>]  [<c011696c>]  [<c0116730>]  [<c0109475>]
Code: f3 a5 bf 00 e0 ff ff 21 e7 ff 47 14 8b 44 24 38 8b 15 b8 b4
 <7>agp_allocate_memory: d5c74de0
agp_allocate_memory: d5c74c60
agp_allocate_memory: d74ba3e0
agp_allocate_memory: d5c74d20
agp_allocate_memory: d5c74e20
agp_allocate_memory: d5c74c20
agp_allocate_memory: d5c74de0
agp_allocate_memory: d5c74c60
agp_allocate_memory: d5c74b20
agp_allocate_memory: d5c74b60
agp_allocate_memory: d5c74ba0
agp_allocate_memory: d5c74be0


-- 
  ricardo galli       GPG id C8114D34
