Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSLAAoI>; Sat, 30 Nov 2002 19:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbSLAAoI>; Sat, 30 Nov 2002 19:44:08 -0500
Received: from dot.freshdot.net ([195.64.80.165]:38418 "EHLO dot.freshdot.net")
	by vger.kernel.org with ESMTP id <S261353AbSLAAoH>;
	Sat, 30 Nov 2002 19:44:07 -0500
Date: Sun, 1 Dec 2002 01:51:32 +0100
From: Sander Smeenk <ssmeenk@freshdot.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 results
Message-ID: <20021201005132.GC22081@dot.freshdot.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021201000034.GA22081@dot.freshdot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201000034.GA22081@dot.freshdot.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sander Smeenk (ssmeenk@freshdot.net):

I have FUP'ing to myself, but sometimes you just have to.

> 1) I get these messages while typing just normal stuff on my keyboard:
> | Dec  1 00:28:00 misery kernel: atkbd.c: Unknown key (set 2, scancode 0x96, on isa0060/serio0) pressed.
> | Dec  1 00:28:10 misery kernel: atkbd.c: Unknown key (set 2, scancode 0xae, on isa0060/serio0) pressed.
> | Dec  1 00:28:13 misery kernel: atkbd.c: Unknown key (set 2, scancode 0x91, on isa0060/serio0) pressed.
> | Dec  1 00:28:23 misery kernel: atkbd.c: Unknown key (set 2, scancode 0xa3, on isa0060/serio0) pressed.
> | Dec  1 00:28:38 misery kernel: atkbd.c: Unknown key (set 2, scancode 0xa6, on isa0060/serio0) pressed.
> I'm not doing anything funny at that moment, just typing commands.
> Messaged appear at a random interval and at random keys.

It seems this only occurs when I type "real fast". If I do 2 keys a second
the messages won't appear. Maybe this might have to do with Toshiba's
key-repeat rate problem, as discussed with Linus, Alan, various X11
coders and this list as a whole earlier. (More info -> google news ->
'toshiba repeating keys')

> 2) Apparently when one boots 2.5.50 without having the newest
> module-init-tools, the kernel panics while doing a shutdown.
> Unfortunately I can't give much more information, because now I have the
> new module-init-tools, and when it happened, all I could see was the
> last bit of the panic.

Ok, just happened again after I tried shutdown -r'ing my laptop.
This time there's more information on the screen, and I Hope This Helps:

<typeovermode>

In interrupt handler - not syncing
 <1>Unable to handle kernel paging request at virtual address 5a5a5a62 printing eip:
c011624d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0060:[<c011624d>]     Not tainted
EFLAGS: 00010093
eax: 5a5a5a5a   ebx: ce040c60   ecx: c132c060   edx: 00000003
esi: c038b524   edi: c038b500   ebp: c12a3d98   esp: c12a3d84
ds: 0068   es: 0068   ss: 0068
Process  (pid: 1031143928, threadinfo=c12a2000 task=c9591000)
Stack: 00000000 00000000 c03d4c23 c12a3d94 00000046 c12a3dac c0116b0d ce0406c0
       00000000 ce4abdfc c12a3de4 c0117e0a ce4abdfc 00000003 00000000 00000000
       00000000 c0116b57 ce4abdfc 00000003 00000000 c12a2000 00000082 c03e6acc
Call Trace: [<c0116b0d>]  [<c0117e0a>]  [<c0116b57>]  [<c0116b90>]  [<c0141f2a>]
  [<c0141f63>]  [<c01420be>]  [<c0144b3b>]  [<c01459b1>]  [<c022ecf6>]  [<c022ed
eb>]  [<c0238dfe>]  [<c024233c>]  [<c024a225>]  [<c023a151>]  [<c024a1b8>]  [<c0
10a59d>]  [<c010a751>]  [<c0109258>]  [<c0110068>]  [<c0119ac0>]  [<c011b590>]  
[<c01097f7>]  [<c0114857>]  [<c0114570>]
Code: 0f ab 50 08 be 01 00 00 00 c7 03 00 00 00 00 8b 45 f8 ff 30
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 
</typeovermode>

HTH 

-- 
| What ees yewr probleem, yew stewpid fewl?
| 1024D/08CEC94D - 34B3 3314 B146 E13C 70C8  9BDB D463 7E41 08CE C94D
