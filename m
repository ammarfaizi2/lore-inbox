Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSL1UuM>; Sat, 28 Dec 2002 15:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSL1UuM>; Sat, 28 Dec 2002 15:50:12 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:42500 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S265670AbSL1UuK>;
	Sat, 28 Dec 2002 15:50:10 -0500
To: harri@synopsys.COM
Cc: linux-kernel@vger.kernel.org
Subject: Re: vgacon: I like Tux, but ...
References: <3E0DFA6A.3020105@Synopsys.COM>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <3E0DFA6A.3020105@Synopsys.COM>
Date: 28 Dec 2002 15:57:56 -0500
Message-ID: <m3wult50a3.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Harald" == Harald Dunkel <harri@synopsys.COM> writes:

Harald> Hi folks, I really like to get Tux displayed on the screen at
Harald> boot time (you should see our SMP machines with hyperthreading
Harald> activated), but if I enter single user mode, then the first 5
Harald> lines remain unusable. I can clear the whole screen, but on
Harald> scrolling upwards the first 5 lines are stuck.

You need to issue a reset.  setterm -reset will do it.  Or:

echo -ne '\033c\033]R'

should.

Either look for the r1, r2, r3 and/or rs strings in /etc/termcap for
the linux terminal type, or use infocmp(1) to get the info:

infocmp -L linux|egrep reset

-JimC


