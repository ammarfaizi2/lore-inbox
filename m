Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSBIRBA>; Sat, 9 Feb 2002 12:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSBIRAv>; Sat, 9 Feb 2002 12:00:51 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:53260 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S289026AbSBIRAn>; Sat, 9 Feb 2002 12:00:43 -0500
Date: Sat, 9 Feb 2002 18:00:40 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input w/2.5.3-dj3
Message-ID: <20020209180040.B18474@suse.cz>
In-Reply-To: <Pine.GSO.4.10.10202081309380.9070-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10202081309380.9070-100000@sound.net>; from hald@sound.net on Fri, Feb 08, 2002 at 01:12:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 01:12:05PM -0600, Hal Duston wrote:
> I have disabled CONTIG_KEYBOARD_XTKBD again.
> 
> Here are the things that might be relevant.
> 
> BTW, this is an IBM Thinkpad 700 PS/2.
> (Microchannel bus)
> 
> Thanks,
> Hal Duston
> hald@sound.net

Thanks for the log, it seems the atkbd.c driver just times out. Can you
change the "timeout" values in drivers/input/keyboard/atkbd.c in the
functions "atkbd_sendbyte" and "atkbd_command" to about ten times the
current values?

That should fix the problem. In either case, please tell me.

> 
> --  Begin console --
>  . . .
> Micro Channel bus detected.
>  . . .
> mice: PS/2 mouse device common for all mice
> serio: i8042 KBD port at 0x60,0x64 irq 1
> input: PS/2 Generic Mouse on isa0060/serio1
> serio: AUX port at 0x60,0x64 irq 12
>  . . .
> --  End console --
> 
> --  Begin /var/log/debug --
> i8042.c: 20 -> i8042 (command) [0]
> i8042.c: 25 <- i8042 (return) [0]
> i8042.c: 60 -> i8042 (command) [0]
> i8042.c: 34 -> i8042 (parameter) [0]
> i8042.c: 60 -> i8042 (command) [0]
> i8042.c: 25 -> i8042 (parameter) [0]
> i8042.c: f6 -> i8042 (kbd-data) [0]
> i8042.c: fa <- i8042 (interrupt-kbd) [0]
> i8042.c: f2 -> i8042 (kbd-data) [0]
> i8042.c: 60 -> i8042 (command) [1]
> i8042.c: 34 -> i8042 (parameter) [1]
> i8042.c: 60 -> i8042 (command) [2]
> i8042.c: 25 -> i8042 (parameter) [2]
> i8042.c: fa <- i8042 (interrupt-kbd) [2]
> atkbd.c: Sent: f5
> i8042.c: f5 -> i8042 (kbd-data) [2]
> i8042.c: 60 -> i8042 (command) [2]
> i8042.c: 34 -> i8042 (parameter) [2]
> i8042.c: fa <- i8042 (flush) [3]
> i8042.c: d3 -> i8042 (command) [3]
> i8042.c: 5a -> i8042 (parameter) [3]
> i8042.c: a5 <- i8042 (return) [3]
> i8042.c: a9 -> i8042 (command) [3]
> i8042.c: 00 <- i8042 (return) [3]
> i8042.c: a7 -> i8042 (command) [3]
> i8042.c: 20 -> i8042 (command) [3]
> i8042.c: 34 <- i8042 (return) [3]
> i8042.c: a9 -> i8042 (command) [3]
> i8042.c: 00 <- i8042 (return) [3]
> i8042.c: a8 -> i8042 (command) [3]
> i8042.c: 20 -> i8042 (command) [3]
> i8042.c: 14 <- i8042 (return) [3]
> i8042.c: 60 -> i8042 (command) [3]
> i8042.c: 34 -> i8042 (parameter) [3]
> i8042.c: 60 -> i8042 (command) [3]
> i8042.c: 16 -> i8042 (parameter) [3]
> i8042.c: d4 -> i8042 (command) [4]
> i8042.c: f6 -> i8042 (parameter) [4]
> i8042.c: 60 -> i8042 (command) [4]
> i8042.c: 16 -> i8042 (parameter) [4]
> i8042.c: fa <- i8042 (interrupt-aux) [4]
> i8042.c: d4 -> i8042 (command) [4]
> i8042.c: f2 -> i8042 (parameter) [4]
> i8042.c: 60 -> i8042 (command) [4]
> i8042.c: 16 -> i8042 (parameter) [4]
> i8042.c: fa <- i8042 (interrupt-aux) [4]
> i8042.c: 00 <- i8042 (interrupt-aux) [4]
> i8042.c: d4 -> i8042 (command) [5]
> i8042.c: e8 -> i8042 (parameter) [5]
> i8042.c: 60 -> i8042 (command) [5]
> i8042.c: 16 -> i8042 (parameter) [5]
> i8042.c: fa <- i8042 (interrupt-aux) [5]
> i8042.c: d4 -> i8042 (command) [5]
> i8042.c: 03 -> i8042 (parameter) [5]
> i8042.c: 60 -> i8042 (command) [5]
> i8042.c: 16 -> i8042 (parameter) [5]
> i8042.c: fa <- i8042 (interrupt-aux) [5]
> i8042.c: d4 -> i8042 (command) [5]
> i8042.c: e6 -> i8042 (parameter) [5]
> i8042.c: 60 -> i8042 (command) [5]
> i8042.c: 16 -> i8042 (parameter) [5]
> i8042.c: fa <- i8042 (interrupt-aux) [6]
> i8042.c: d4 -> i8042 (command) [6]
> i8042.c: e6 -> i8042 (parameter) [6]
> i8042.c: 60 -> i8042 (command) [6]
> i8042.c: 16 -> i8042 (parameter) [6]
> i8042.c: fa <- i8042 (interrupt-aux) [6]
> i8042.c: d4 -> i8042 (command) [6]
> i8042.c: e6 -> i8042 (parameter) [6]
> i8042.c: 60 -> i8042 (command) [6]
> i8042.c: 16 -> i8042 (parameter) [6]
> i8042.c: fa <- i8042 (interrupt-aux) [7]
> i8042.c: d4 -> i8042 (command) [7]
> i8042.c: e9 -> i8042 (parameter) [7]
> i8042.c: 60 -> i8042 (command) [7]
> i8042.c: 16 -> i8042 (parameter) [7]
> i8042.c: fa <- i8042 (interrupt-aux) [7]
> i8042.c: 00 <- i8042 (interrupt-aux) [7]
> i8042.c: 03 <- i8042 (interrupt-aux) [7]
> i8042.c: 64 <- i8042 (interrupt-aux) [8]
> i8042.c: d4 -> i8042 (command) [8]
> i8042.c: e8 -> i8042 (parameter) [8]
> i8042.c: 60 -> i8042 (command) [8]
> i8042.c: 16 -> i8042 (parameter) [8]
> i8042.c: fa <- i8042 (interrupt-aux) [8]
> i8042.c: d4 -> i8042 (command) [8]
> i8042.c: 00 -> i8042 (parameter) [8]
> i8042.c: 60 -> i8042 (command) [8]
> i8042.c: 16 -> i8042 (parameter) [8]
> i8042.c: fa <- i8042 (interrupt-aux) [8]
> i8042.c: d4 -> i8042 (command) [8]
> i8042.c: e6 -> i8042 (parameter) [8]
> i8042.c: 60 -> i8042 (command) [9]
> i8042.c: 16 -> i8042 (parameter) [9]
> i8042.c: fa <- i8042 (interrupt-aux) [9]
> i8042.c: d4 -> i8042 (command) [9]
> i8042.c: e6 -> i8042 (parameter) [9]
> i8042.c: 60 -> i8042 (command) [9]
> i8042.c: 16 -> i8042 (parameter) [9]
> i8042.c: fa <- i8042 (interrupt-aux) [9]
> i8042.c: d4 -> i8042 (command) [9]
> i8042.c: e6 -> i8042 (parameter) [9]
> i8042.c: 60 -> i8042 (command) [9]
> i8042.c: 16 -> i8042 (parameter) [9]
> i8042.c: fa <- i8042 (interrupt-aux) [10]
> i8042.c: d4 -> i8042 (command) [10]
> i8042.c: e9 -> i8042 (parameter) [10]
> i8042.c: 60 -> i8042 (command) [10]
> i8042.c: 16 -> i8042 (parameter) [10]
> i8042.c: fa <- i8042 (interrupt-aux) [10]
> i8042.c: 00 <- i8042 (interrupt-aux) [10]
> i8042.c: 00 <- i8042 (interrupt-aux) [11]
> i8042.c: 64 <- i8042 (interrupt-aux) [11]
> i8042.c: d4 -> i8042 (command) [11]
> i8042.c: f3 -> i8042 (parameter) [11]
> i8042.c: 60 -> i8042 (command) [11]
> i8042.c: 16 -> i8042 (parameter) [11]
> i8042.c: fa <- i8042 (interrupt-aux) [11]
> i8042.c: d4 -> i8042 (command) [11]
> i8042.c: c8 -> i8042 (parameter) [11]
> i8042.c: 60 -> i8042 (command) [11]
> i8042.c: 16 -> i8042 (parameter) [11]
> i8042.c: fa <- i8042 (interrupt-aux) [11]
> i8042.c: d4 -> i8042 (command) [11]
> i8042.c: f3 -> i8042 (parameter) [11]
> i8042.c: 60 -> i8042 (command) [12]
> i8042.c: 16 -> i8042 (parameter) [12]
> i8042.c: fa <- i8042 (interrupt-aux) [12]
> i8042.c: d4 -> i8042 (command) [12]
> i8042.c: 64 -> i8042 (parameter) [12]
> i8042.c: 60 -> i8042 (command) [12]
> i8042.c: 16 -> i8042 (parameter) [12]
> i8042.c: fa <- i8042 (interrupt-aux) [12]
> i8042.c: d4 -> i8042 (command) [12]
> i8042.c: f3 -> i8042 (parameter) [12]
> i8042.c: 60 -> i8042 (command) [12]
> i8042.c: 16 -> i8042 (parameter) [12]
> i8042.c: fa <- i8042 (interrupt-aux) [13]
> i8042.c: d4 -> i8042 (command) [13]
> i8042.c: 50 -> i8042 (parameter) [13]
> i8042.c: 60 -> i8042 (command) [13]
> i8042.c: 16 -> i8042 (parameter) [13]
> i8042.c: fa <- i8042 (interrupt-aux) [13]
> i8042.c: d4 -> i8042 (command) [13]
> i8042.c: f2 -> i8042 (parameter) [13]
> i8042.c: 60 -> i8042 (command) [13]
> i8042.c: 16 -> i8042 (parameter) [13]
> i8042.c: fa <- i8042 (interrupt-aux) [14]
> i8042.c: 00 <- i8042 (interrupt-aux) [14]
> i8042.c: d4 -> i8042 (command) [14]
> i8042.c: f3 -> i8042 (parameter) [14]
> i8042.c: 60 -> i8042 (command) [14]
> i8042.c: 16 -> i8042 (parameter) [14]
> i8042.c: fa <- i8042 (interrupt-aux) [14]
> i8042.c: d4 -> i8042 (command) [14]
> i8042.c: 64 -> i8042 (parameter) [14]
> i8042.c: 60 -> i8042 (command) [15]
> i8042.c: 16 -> i8042 (parameter) [15]
> i8042.c: fa <- i8042 (interrupt-aux) [15]
> i8042.c: d4 -> i8042 (command) [15]
> i8042.c: f3 -> i8042 (parameter) [15]
> i8042.c: 60 -> i8042 (command) [15]
> i8042.c: 16 -> i8042 (parameter) [15]
> i8042.c: fa <- i8042 (interrupt-aux) [15]
> i8042.c: d4 -> i8042 (command) [15]
> i8042.c: c8 -> i8042 (parameter) [15]
> i8042.c: 60 -> i8042 (command) [15]
> i8042.c: 16 -> i8042 (parameter) [15]
> i8042.c: fa <- i8042 (interrupt-aux) [16]
> i8042.c: d4 -> i8042 (command) [16]
> i8042.c: e8 -> i8042 (parameter) [16]
> i8042.c: 60 -> i8042 (command) [16]
> i8042.c: 16 -> i8042 (parameter) [16]
> i8042.c: fa <- i8042 (interrupt-aux) [16]
> i8042.c: d4 -> i8042 (command) [16]
> i8042.c: 03 -> i8042 (parameter) [16]
> i8042.c: 60 -> i8042 (command) [16]
> i8042.c: 16 -> i8042 (parameter) [16]
> i8042.c: fa <- i8042 (interrupt-aux) [16]
> i8042.c: d4 -> i8042 (command) [16]
> i8042.c: e6 -> i8042 (parameter) [16]
> i8042.c: 60 -> i8042 (command) [17]
> i8042.c: 16 -> i8042 (parameter) [17]
> i8042.c: fa <- i8042 (interrupt-aux) [17]
> i8042.c: d4 -> i8042 (command) [17]
> i8042.c: ea -> i8042 (parameter) [17]
> i8042.c: 60 -> i8042 (command) [17]
> i8042.c: 16 -> i8042 (parameter) [17]
> i8042.c: fa <- i8042 (interrupt-aux) [17]
> i8042.c: d4 -> i8042 (command) [17]
> i8042.c: f4 -> i8042 (parameter) [17]
> i8042.c: 60 -> i8042 (command) [18]
> i8042.c: 16 -> i8042 (parameter) [18]
> i8042.c: fa <- i8042 (interrupt-aux) [18]
> --  End /var/log/debug --

-- 
Vojtech Pavlik
SuSE Labs
