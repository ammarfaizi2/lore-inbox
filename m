Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUIGGz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUIGGz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267682AbUIGGz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:55:27 -0400
Received: from ns3.phade.de ([62.67.209.1]:5271 "EHLO pc6.berlin3.powerweb.de")
	by vger.kernel.org with ESMTP id S267681AbUIGGzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:55:15 -0400
Message-ID: <413D5B41.4040500@powerweb.de>
Date: Tue, 07 Sep 2004 08:54:57 +0200
From: Frank Gadegast <frank@powerweb.de>
Reply-To: frank@powerweb.de
Organization: PHADE Software - PowerWeb
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at transaction.c
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

found the following bug with kernel 2.4.26 on a SMP machine with
Redhat 9.0, is there already a fix ?

EXT3-fs error (device sd(8,3)): ext3_free_blocks: bit already cleared 
for block 67110304
EXT3-fs error (device sd(8,3)): ext3_free_blocks: Freeing block in 
system zone - block = 16777216
EXT3-fs error (device sd(8,3)): ext3_free_blocks: Freeing blocks not in 
datazone - block = 873594880, count = 1
Assertion failure in journal_forget_Rsmp_57aea4d2() at 
transaction.c:1257: "!jh->b_committed_data"
kernel BUG at transaction.c:1257!
invalid operand: 0000
CPU:    1
EIP:    0010:[<f880e469>]    Not tainted
EFLAGS: 00010296
eax: 00000066   ebx: f4eca460   ecx: 00000092   edx: 00000001
esi: f50cdb60   edi: f5d90694   ebp: f5d90600   esp: f5977c38
ds: 0018   es: 0018   ss: 0018
Process imageFolio.cgi (pid: 1049, stackpage=f5977000)
Stack: f8814460 f88162d9 f881615a 000004e9 f88162f6 f59ceda0 01000000 
f5a24e60
        f5942aa0 f5942aa0 f881e0b3 f5a24e60 f50cdb60 00000000 f5a24e80 
f5977ce8
        f3464860 f8821661 f5a24e80 f5977cbc 00000001 00000000 f5977cd0 
f881ec0b
Call Trace:    [<f8814460>] [<f88162d9>] [<f881615a>] [<f88162f6>] 
[<f881e0b3>]
   [<f8821661>] [<f881ec0b>] [<f882023f>] [<c02283c0>] [<c02518fb>] 
[<f880dd3f>]
   [<f8820363>] [<f880d288>] [<f880d39d>] [<f88207a5>] [<c012e88b>] 
[<f8821661>]
   [<f88230bf>] [<f8820630>] [<c012c3fa>] [<c01574d6>] [<f8821505>] 
[<f8821606>]
   [<c0157679>] [<c0153bbc>] [<c014a4e0>] [<c013e1f0>] [<c0153bbc>] 
[<c014bc74>]
   [<c0153bbc>] [<c01300f0>] [<c013f1b6>] [<c013f504>] [<c0108b6f>]

Code: 0f 0b e9 04 5a 61 81 f8 83 c4 14 53 e8 56 03 00 00 8b 4b 24

Kind regards, Frank
-- 
--
PHADE Software - PowerWeb                       http://www.powerweb.de
Inh. Dipl.-Inform. Frank Gadegast             mailto:frank@powerweb.de
Otto-Nagel-Str. 1a                                fon: +49 331 2370780
14467 Potsdam, Germany                            fax: +49 331 2370781
======================================================================
Public PGP Key available for frank@powerweb.de


