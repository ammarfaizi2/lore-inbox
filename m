Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317912AbSFSPmm>; Wed, 19 Jun 2002 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317913AbSFSPml>; Wed, 19 Jun 2002 11:42:41 -0400
Received: from vivi.uptime.at ([62.116.87.11]:63636 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S317912AbSFSPmh>;
	Wed, 19 Jun 2002 11:42:37 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Holzrichter, Bruce'" <bruce.holzrichter@monster.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: New Build problem in sched.c in 2.5.23 on an Alpha
Date: Wed, 19 Jun 2002 17:42:15 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000701c217a7$e63e3910$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-reply-to: <61DB42B180EAB34E9D28346C11535A783A79A2@nocmail101.ma.tmpw.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Holzrichter wrote:
[ ... ]
> What Arch are you on?  Alpha?

Yes, it's an Alpha.

> Search the archive, you'll see that some of these are from 
> Ingo's scheduler changes.

I found some information which helped me. This problem is now
solved, but I got a new _strange_ one... I'm not a a asm-gure, so
I don't know how to handle _this_................ Are all these
errors because of the missing "regdef.h"? And if yes, why is it
missing!? :-(

Here it comes:
[ ... ]
  gcc -Wp,-MD,./.stxcpy.o.d -D__ASSEMBLY__ -D__KERNEL__
-I/usr/src/linux-2.5.23/include -nostdinc -iwithprefix includ
e  -D__KERNEL__ -I/usr/src/linux-2.5.23/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fn
o-common -fomit-frame-pointer -pipe -mno-fp-regs -ffixed-8 -mcpu=ev5
-Wa,-mev6  -c -o stxcpy.o stxcpy.S
stxcpy.S:23:26: alpha/regdef.h: No such file or directory
stxcpy.S: Assembler messages:
stxcpy.S:46: Error: inappropriate arguments for opcode `lda'
stxcpy.S:47: Error: inappropriate arguments for opcode `mskqh'
stxcpy.S:48: Error: inappropriate arguments for opcode `mskqh'
stxcpy.S:49: Error: inappropriate arguments for opcode `ornot'
stxcpy.S:50: Error: inappropriate arguments for opcode `mskql'
stxcpy.S:51: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:52: Error: inappropriate arguments for opcode `or'
stxcpy.S:53: Error: inappropriate arguments for opcode `bne'
stxcpy.S:60: Error: syntax error
stxcpy.S:61: Error: inappropriate arguments for opcode `addq'
stxcpy.S:62: Error: syntax error
stxcpy.S:63: Error: inappropriate arguments for opcode `addq'
stxcpy.S:64: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:65: Error: inappropriate arguments for opcode `beq'
stxcpy.S:72: Error: inappropriate arguments for opcode `negq'
stxcpy.S:73: Error: inappropriate arguments for opcode `and'
stxcpy.S:77: Error: inappropriate arguments for opcode `and'
stxcpy.S:78: Error: inappropriate arguments for opcode `bne'
stxcpy.S:82: Error: syntax error
stxcpy.S:83: Error: inappropriate arguments for opcode `subq'
stxcpy.S:84: Error: inappropriate arguments for opcode `zapnot'
stxcpy.S:85: Error: inappropriate arguments for opcode `or'
stxcpy.S:86: Error: inappropriate arguments for opcode `zap'
stxcpy.S:87: Error: inappropriate arguments for opcode `or'
stxcpy.S:89: Error: syntax error
stxcpy.S:102: Error: inappropriate arguments for opcode `xor'
stxcpy.S:104: Error: inappropriate arguments for opcode `and'
stxcpy.S:105: Error: inappropriate arguments for opcode `bne'
stxcpy.S:108: Error: syntax error
stxcpy.S:109: Error: inappropriate arguments for opcode `and'
stxcpy.S:110: Error: inappropriate arguments for opcode `addq'
stxcpy.S:111: Error: inappropriate arguments for opcode `beq'
stxcpy.S:112: Error: syntax error
stxcpy.S:131: Error: syntax error
stxcpy.S:132: Error: inappropriate arguments for opcode `addq'
stxcpy.S:134: Error: inappropriate arguments for opcode `extql'
stxcpy.S:135: Error: inappropriate arguments for opcode `extqh'
stxcpy.S:136: Error: inappropriate arguments for opcode `mskql'
stxcpy.S:137: Error: inappropriate arguments for opcode `or'
stxcpy.S:138: Error: inappropriate arguments for opcode `mskqh'
stxcpy.S:139: Error: inappropriate arguments for opcode `or'
stxcpy.S:141: Error: inappropriate arguments for opcode `or'
stxcpy.S:142: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:143: Error: inappropriate arguments for opcode `lda'
stxcpy.S:144: Error: inappropriate arguments for opcode `bne'
stxcpy.S:146: Error: inappropriate arguments for opcode `mskql'
stxcpy.S:147: Error: inappropriate arguments for opcode `or'
stxcpy.S:148: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:149: Error: inappropriate arguments for opcode `bne'
stxcpy.S:154: Error: syntax error
stxcpy.S:155: Error: inappropriate arguments for opcode `addq'
stxcpy.S:156: Error: inappropriate arguments for opcode `extql'
stxcpy.S:157: Error: syntax error
stxcpy.S:158: Error: inappropriate arguments for opcode `addq'
stxcpy.S:159: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:161: Error: inappropriate arguments for opcode `bne'
stxcpy.S:178: Error: inappropriate arguments for opcode `extqh'
stxcpy.S:179: Error: inappropriate arguments for opcode `addq'
stxcpy.S:180: Error: inappropriate arguments for opcode `extql'
stxcpy.S:181: Error: inappropriate arguments for opcode `addq'
stxcpy.S:182: Error: inappropriate arguments for opcode `or'
stxcpy.S:183: Error: syntax error
stxcpy.S:184: Error: syntax error
stxcpy.S:185: Error: inappropriate arguments for opcode `mov'
stxcpy.S:186: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:187: Error: inappropriate arguments for opcode `beq'
stxcpy.S:198: Error: inappropriate arguments for opcode `extqh'
stxcpy.S:199: Error: inappropriate arguments for opcode `or'
stxcpy.S:201: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:202: Error: inappropriate arguments for opcode `bne'
stxcpy.S:205: Error: syntax error
stxcpy.S:206: Error: inappropriate arguments for opcode `addq'
stxcpy.S:207: Error: inappropriate arguments for opcode `extql'
stxcpy.S:208: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:215: Error: inappropriate arguments for opcode `negq'
stxcpy.S:216: Error: inappropriate arguments for opcode `and'
stxcpy.S:218: Error: inappropriate arguments for opcode `and'
stxcpy.S:219: Error: inappropriate arguments for opcode `bne'
stxcpy.S:221: Error: syntax error
stxcpy.S:222: Error: inappropriate arguments for opcode `subq'
stxcpy.S:223: Error: inappropriate arguments for opcode `or'
stxcpy.S:224: Error: inappropriate arguments for opcode `zapnot'
stxcpy.S:225: Error: inappropriate arguments for opcode `zap'
stxcpy.S:226: Error: inappropriate arguments for opcode `or'
stxcpy.S:228: Error: syntax error
stxcpy.S:235: Error: syntax error
stxcpy.S:237: Error: inappropriate arguments for opcode `and'
stxcpy.S:238: Error: inappropriate arguments for opcode `and'
stxcpy.S:243: Error: inappropriate arguments for opcode `mov'
stxcpy.S:244: Error: inappropriate arguments for opcode `mov'
stxcpy.S:245: Error: inappropriate arguments for opcode `beq'
stxcpy.S:246: Error: syntax error
stxcpy.S:247: Error: inappropriate arguments for opcode `lda'
stxcpy.S:248: Error: inappropriate arguments for opcode `mskql'
stxcpy.S:250: Error: inappropriate arguments for opcode `subq'
stxcpy.S:255: Error: inappropriate arguments for opcode `cmplt'
stxcpy.S:256: Error: inappropriate arguments for opcode `beq'
stxcpy.S:258: Error: inappropriate arguments for opcode `lda'
stxcpy.S:259: Error: inappropriate arguments for opcode `mskqh'
stxcpy.S:261: Error: inappropriate arguments for opcode `ornot'
stxcpy.S:262: Error: inappropriate arguments for opcode `cmpbge'
stxcpy.S:263: Error: inappropriate arguments for opcode `beq'
stxcpy.S:270: Error: syntax error
stxcpy.S:272: Error: inappropriate arguments for opcode `negq'
stxcpy.S:273: Error: inappropriate arguments for opcode `and'
stxcpy.S:274: Error: inappropriate arguments for opcode `and'
stxcpy.S:275: Error: inappropriate arguments for opcode `subq'
stxcpy.S:276: Error: inappropriate arguments for opcode `or'
stxcpy.S:277: Error: inappropriate arguments for opcode `srl'
stxcpy.S:279: Error: inappropriate arguments for opcode `zapnot'
stxcpy.S:280: Error: inappropriate arguments for opcode `and'
stxcpy.S:281: Error: inappropriate arguments for opcode `extql'
stxcpy.S:282: Error: inappropriate arguments for opcode `extql'
stxcpy.S:284: Error: inappropriate arguments for opcode `andnot'
stxcpy.S:285: Error: inappropriate arguments for opcode `or'
stxcpy.S:286: Error: syntax error
make[1]: *** [stxcpy.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.23/arch/alpha/lib'
make: *** [arch/alpha/lib] Error 2

Ideas?

-Oliver


