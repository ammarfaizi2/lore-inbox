Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268814AbRHBGbB>; Thu, 2 Aug 2001 02:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268816AbRHBGav>; Thu, 2 Aug 2001 02:30:51 -0400
Received: from goliath.siemens.de ([194.138.37.131]:58353 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S268814AbRHBGam>; Thu, 2 Aug 2001 02:30:42 -0400
X-Envelope-Sender-Is: Andrej.Borsenkow@mow.siemens.ru (at relayer goliath.siemens.de)
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Subject: Persistent device numbers
Date: Thu, 2 Aug 2001 10:30:44 +0400
Message-ID: <000901c11b1c$a87b1f40$21c9ca95@mow.siemens.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As far as I understand, currently kernel assigns device numbers dynamically.
It means, that actual, user visible, controller/drive name may change if

- hardware configuaration is changed (added ot removed controller, added or
removed drive)

- for some reasons order of initialisation in kernel changes (which may
result in nasty surprise after update)

Moreover, it near to impossible to know which name device gets in advance
(or why it gets this name).

Most commercial systems (O.K. those I looked into) have some sort of logical
device numbering that assigns fixed name based on some unique hardware
address (cf /etc/path_to_inst in Solaris). Hardware address usually is a
path needed to access device - i.e. Bus/Slot/Channel[/drive id], so that you
can set

PCI0/Slot3/Channel1 == eth3

and this never changes if you add or remove any card.

Do I miss something and Linux has such mechanism?

TIA

-andrej
