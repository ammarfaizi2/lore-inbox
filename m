Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbTJTUnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTJTUnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:43:05 -0400
Received: from aua2.aua.auc.dk ([130.225.54.5]:13841 "EHLO aua2.aua.auc.dk")
	by vger.kernel.org with ESMTP id S262851AbTJTUnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:43:01 -0400
Date: Mon, 20 Oct 2003 22:42:20 +0200
From: Martin Fejrskov Pedersen <martin@fejrskov.dk>
Subject: Yenta freeze on laptop with O2Micro cardbus controller.
To: linux-kernel@vger.kernel.org
Message-id: <200310202242.20849.martin@fejrskov.dk>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
User-Agent: KMail/1.4.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
 In the changelog of kernel 2.4.22 stable Alan Cox mentions a "fix yenta hang 
on some laptops" in the summary of changes from v2.4.22-pre5 to v2.4.22-pre6. 
I was extatic to have a look at this, since I've had this problem for a long 
time with my laptop. The problem still exists, however. 

The laptop is a Chicony MP­-995 with an 02micro cardbus controller. There 
are no relevant BIOS settings (such as "PNP OS = off") available. I have tried 
to disable serial ports etc. in the BIOS and tried to insert the port and 
memory values reported by Win98 in /etc/sysconfig/pcmcia and 
/etc/pcmcia/config.opts and excluded already used interrupts, as reported 
by /proc/interrupts.

I have tried Mandrake version 8.2 upwards including 9.1, RedHat 9.0 and 
Knoppix 3.1. All make the computer freeze. With older RedHats and Mandrakes 
everything is fine, most likely because they changed from the 
non-kernel-pcmcia-thingies to the yenta-thingy.

I suspect that it's maybe flaky IO-port/IRQ probing or kernel module(s), since 
on boot, the kernel says something about not being able to find an IRQ 
router. I don't know how to proceed, since I have run dry on ideas. Is there 
something, I can do to help solve this problem, without having to learn 
everything about pcmcia and yenta?

Regards
Martin Fejrskov
Denmark

PS: I tried to send this mail directly to Alan Cox, but as we all know, he is 
on autoresponder right now. I sent it to Rik van Riel, who directed me here. 
If there is a more appropriate forum, please tell me.
