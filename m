Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267090AbUBFA1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 19:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267092AbUBFA1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 19:27:22 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:33709 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267090AbUBFAZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 19:25:16 -0500
Subject: Re : Re : Alsa create high problems...
From: Eddahbi Karim <installation_fault_association@yahoo.fr>
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz
Content-Type: text/plain
Organization: Installation Fault
Message-Id: <1076027038.7282.4.camel@gamux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 01:23:58 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I got more informations.
I compiled ALSA in modules this time (Kernel modules) and it seems that
I got a different backtrace :

irq 11: nobody cared!
Call Trace:
 [<c010c52b>] __report_bad_irq+0x2b/0x90
 [<c010c624>] note_interrupt+0x64/0xa0
 [<c010cc53>] do_IRQ+0x293/0x360
 [<c010aa3c>] common_interrupt+0x18/0x20
 [<c012c494>] do_softirq+0x94/0xa0
 [<c010cbf7>] do_IRQ+0x237/0x360
 [<c012b894>] sys_gettimeofday+0x64/0xd0
 [<c010aa3c>] common_interrupt+0x18/0x20
 
handlers:
[<e1b547e0>] (snd_via82xx_interrupt+0x0/0x460 [snd_via82xx])
Disabling IRQ #11

The con, I have always the bug which I can unlock only via :
cat /proc/asound/card0/pcm0p/sub0/status

The pro, I can get rid of the problem if I remove the alsa 
module "snd_via82xx" and I reload it.

ALSA 2 : Modules RELOADED :D

Best regards,

-- 
Eddahbi Karim <installation_fault_association@yahoo.fr>
Installation Fault

