Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUGNK5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUGNK5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUGNK5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:57:16 -0400
Received: from mailrelay.nefonline.de ([212.114.153.196]:10214 "EHLO
	mailrelay1.nefonline.de") by vger.kernel.org with ESMTP
	id S267365AbUGNK5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:57:07 -0400
Date: Wed, 14 Jul 2004 12:57:05 +0200
From: Hermann Gottschalk <hg@ostc.de>
To: linux-kernel@vger.kernel.org
Subject: [hg@ostc.de: Re: Strange Network behaviour]
Message-ID: <20040714105705.GB12380@ostc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-PGP-Key: 1024D/0B2D8EEA 2004-06-07 Hermann Gottschalk (OSTC) <hg@ostc.de>
X-PGP-Fingerprint: 9A36 D20E B7FB BE5D 11DB  3006 3ADA D083 0B2D 8EEA
X-Operating-System: Linux 2.4.21-231-default
X-message-flag: Please do NOT send HTML e-mail or MS Word attachments - use plain text instead
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jul 14, 2004 at 12:48:58PM +0200, Roger Luethi wrote:
> On Wed, 14 Jul 2004 12:40:08 +0200, Hermann Gottschalk wrote:
> > On Wed, Jul 14, 2004 at 12:33:12PM +0200, Roger Luethi wrote:
> > > On Wed, 14 Jul 2004 12:28:49 +0200, Hermann Gottschalk wrote:
> > > > > If you set debug in via-rhine to 3, you'll get a more interesting
> > > > > log. Does booting with noacpi help at all?
> > > > 
> > > > I will try noapic.
> > > 
> > > noapic != noacpi
> > > Both ACPI and APIC have been known to cause problems, though.
> > 
> > noacpi doesn't exist as kernel-parameter
> > (/usr/src/linum/Documentation/kernel-parameters.ext)
> 
> Correct. AC-pi=off does.

Sorry,
found it too...

After restart with noapic lvm causes the same problems...

dmesg
...
kernel BUG at memory.c:531!
invalid operand: 0000 2.4.21-231-default #1 Mon Jun 28 15:39:34 UTC 2004
CPU:    0
EIP:    0010:[<c012db64>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c10e47a0   ecx: 0000000b   edx: c27ffd40
esi: c28031f0   edi: 00000000   ebp: 00000004   esp: ca121d7c
ds: 0018   es: 0018   ss: 0018
Process lvremove (pid: 8434, stackpage=ca121000)
Stack: c10e47a0 c4485120 c012dfd7 c10e47a0 c4462800 c4462800 c4462000 c4495447
       c4485120 c4485120 c44fa000 c44936c4 c4462800 c4462170 4004fe21 00000000
       c44fa000 bffff320 c4490940 00000000 c4499ca0 ffffffff ca3f09a0 ca124ed0
Call Trace:         [<c012dfd7>] (20) [<c4495447>] (16) [<c44936c4>] (28)
  [<c4490940>] (08) [<c4499ca0>] (16) [<c012f795>] (44) [<c0118718>] (56)
  [<c01c0d05>] (32) [<c013ab0c>] (16) [<c013437e>] (28) [<c86f2924>] (20)
  [<c012f2d3>] (72) [<c014ed80>] (24) [<c0151c8a>] (16) [<c014492b>] (16)
  [<c010c5b8>] (32) [<c0144a94>] (24) [<c01438f4>] (28) [<c01437b0>] (24)
  [<c0152e26>] (32) [<c0143b0c>] (20) [<c0108e13>] (60)
Modules: [(e1000:<c86f0060>:<c86ff944>)] [(lvm-mod:<c4490060>:<c449f644>)]
Code: 0f 0b 13 02 a6 22 2a c0 eb dc 89 f6 55 57 56 53 57 57 83 7c

-----------------------------
I will reboot them this evening with both noapic and acpi=off...

But I'm not very hopefull...
Greetings

-- 
  ___  ___ _____ ___    ___       _    _  _
 / _ \/ __|_   _/ __|  / __|_ __ | |__| || |
| (_) \__ \ | || (__  | (_ | '  \| '_ \ __ |
 \___/|___/ |_| \___|  \___|_|_|_|_.__/_||_|
----------------------------------------------
 OSTC Open Source Training and Consulting GmbH
 90425 Nürnberg      Web:   http://www.ostc.de
----------------------------------------------
            PGP-Key: 0x0B2D8EEA 
    No HTML-Mails; 72 Characters per line
