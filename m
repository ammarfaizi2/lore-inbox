Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265500AbUFXPVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUFXPVP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUFXPVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:21:14 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:25353 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S265500AbUFXPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:20:05 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Thu, 24 Jun 2004 17:19:11 +0200
User-Agent: KMail/1.6
Cc: t.hirsch@web.de, laflipas@telefonica.net, linux-kernel@vger.kernel.org
References: <20040623155944.96871.qmail@web81304.mail.yahoo.com>
In-Reply-To: <20040623155944.96871.qmail@web81304.mail.yahoo.com>
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406241719.11683.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 24 Jun 2004 15:19:16.0500 (UTC) FILETIME=[9D123D40:01C459FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. Juni 2004 17.59 schrieb Dmitry Torokhov unter "RE: Continue: 
psmouse.c - synaptics touchpad driver sync problem":
> Also, if you have time, please change #undef DEBUG to #define DEBUG in
> drivers/input/serio/i8042.c, reboot, play a bit with touchpad; plug
> external keyboard and send me output of "dmesg -s 100000".

dmesg looks like this, even with a log_buf_len=131072 boot-parameter, there's 
nothiung else left. These are the interesting parts:

[dmesg starts here, this is first line]
erio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [158589]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158592]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158593]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [158595]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158596]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158598]
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [158602]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158603]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158605]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [158606]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158608]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158609]
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [158614]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158617]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158619]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [158622]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158623]
[...]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [158974]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158977]
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158978]
psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [158980]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158981]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158983]
drivers/input/serio/i8042.c: c0 <- i8042 (interrupt, aux1, 12) [158985]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158987]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158988]
psmouse.c: TouchPad at isa0060/serio2/input0 - driver resynched.
drivers/input/serio/i8042.c: 80 <- i8042 (interrupt, aux1, 12) [158990]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158991]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158993]
[...]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [159396]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [159398]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, kbd, 1) [162523]
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
trying access hardware directly.
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, aux3, 12) [162765]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162765]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162765]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [162765]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162769]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162771]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162771]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [162771]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162774]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162776]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162776]
drivers/input/serio/i8042.c: f6 -> i8042 (parameter) [162776]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162779]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162779]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [162779]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162782]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162782]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [162782]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162785]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162785]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [162785]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162788]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162788]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [162788]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162791]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162791]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [162791]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162794]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162794]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [162794]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162797]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162797]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [162797]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162800]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162800]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [162800]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162804]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162804]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [162804]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162807]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162809]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162810]
drivers/input/serio/i8042.c: 64 <- i8042 (interrupt, aux3, 12) [162812]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162812]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [162812]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162816]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162816]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [162816]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162819]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162819]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [162819]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162822]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162822]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [162822]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162825]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162825]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [162825]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162828]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162828]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [162828]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162831]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, aux3, 12) [162833]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux3, 12) [162835]
drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, aux3, 12) [162839]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162839]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [162839]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162842]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162842]
drivers/input/serio/i8042.c: 00 -> i8042 (parameter) [162842]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162845]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162845]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [162845]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162848]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162848]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [162848]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162851]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162851]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [162851]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162854]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162854]
drivers/input/serio/i8042.c: e9 -> i8042 (parameter) [162854]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162857]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, aux3, 12) [162859]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux3, 12) [162861]
drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, aux3, 12) [162863]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162863]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [162863]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162866]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162866]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [162866]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162869]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162869]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [162869]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162872]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162872]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [162872]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162875]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162875]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [162875]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162878]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162878]
drivers/input/serio/i8042.c: 50 -> i8042 (parameter) [162878]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162881]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162881]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [162881]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162885]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162887]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162887]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [162887]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162890]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162890]
drivers/input/serio/i8042.c: c8 -> i8042 (parameter) [162890]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162893]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162893]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [162893]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162896]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162896]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [162896]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162899]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162899]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [162899]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162902]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162902]
drivers/input/serio/i8042.c: 50 -> i8042 (parameter) [162902]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162905]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [162905]
drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [162905]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [162908]
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux3, 12) [162910]
input: PS/2 Logitech Mouse on isa0060/serio4
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163005]
drivers/input/serio/i8042.c: f3 -> i8042 (parameter) [163005]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163008]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163008]
drivers/input/serio/i8042.c: 64 -> i8042 (parameter) [163008]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163011]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163011]
drivers/input/serio/i8042.c: e8 -> i8042 (parameter) [163011]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163015]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163015]
drivers/input/serio/i8042.c: 03 -> i8042 (parameter) [163015]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163018]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163018]
drivers/input/serio/i8042.c: e6 -> i8042 (parameter) [163018]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163021]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163021]
drivers/input/serio/i8042.c: ea -> i8042 (parameter) [163021]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163024]
drivers/input/serio/i8042.c: 93 -> i8042 (command) [163024]
drivers/input/serio/i8042.c: f4 -> i8042 (parameter) [163024]
drivers/input/serio/i8042.c: fa <- i8042 (interrupt, aux3, 12) [163027]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux3, 12) [165329]
drivers/input/serio/i8042.c: 01 <- i8042 (interrupt, aux3, 12) [165331]
drivers/input/serio/i8042.c: 03 <- i8042 (interrupt, aux3, 12) [165332]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, aux3, 12) [165342]
[...]
drivers/input/serio/i8042.c: 88 <- i8042 (interrupt, kbd, 1) [205896]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 1) [205921]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [206158]
drivers/input/serio/i8042.c: b2 <- i8042 (interrupt, kbd, 1) [206238]
drivers/input/serio/i8042.c: 31 <- i8042 (interrupt, kbd, 1) [206335]
drivers/input/serio/i8042.c: b1 <- i8042 (interrupt, kbd, 1) [206380]
drivers/input/serio/i8042.c: 14 <- i8042 (interrupt, kbd, 1) [206415]
drivers/input/serio/i8042.c: 94 <- i8042 (interrupt, kbd, 1) [206462]
drivers/input/serio/i8042.c: 2a <- i8042 (interrupt, kbd, 1) [206672]
drivers/input/serio/i8042.c: 08 <- i8042 (interrupt, kbd, 1) [206794]
drivers/input/serio/i8042.c: 88 <- i8042 (interrupt, kbd, 1) [206839]
drivers/input/serio/i8042.c: aa <- i8042 (interrupt, kbd, 1) [206892]
drivers/input/serio/i8042.c: 20 <- i8042 (interrupt, kbd, 1) [207131]
drivers/input/serio/i8042.c: a0 <- i8042 (interrupt, kbd, 1) [207196]
drivers/input/serio/i8042.c: 32 <- i8042 (interrupt, kbd, 1) [207317]
[...]
drivers/input/serio/i8042.c: a2 <- i8042 (interrupt, kbd, 1) [207951]
drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, kbd, 1) [209407]
drivers/input/serio/i8042.c: 9c <- i8042 (interrupt, kbd, 1) [209458]
[end of dmesg, that was last line]

All the other lines look similar to:
drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, aux1, 12) [158654]

There is no more left from the boot process. That means, the trace is so 
frequent, that it overflows long before I can get the dmesg. I also tried 
with 33554432 Bytes, but there seem to be a size limit?

I don't think it makes sense to attach the full trace (>100kB), I don't want 
to send too large messages, what do you think?


Please tell me if you have any idea how to proceed.


Regards
Marc
