Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUCYWgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbUCYWfJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:35:09 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:64391 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S263682AbUCYWdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:33:17 -0500
Subject: Re: swsusp is not reliable. Face it. [was Re: [Swsusp-devel] Re:
	swsusp problems]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Frank <mhf@linuxmail.org>,
       Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
In-Reply-To: <20040325221348.GB2179@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
	 <200403232352.58066.dtor_core@ameritech.net>
	 <20040324102233.GC512@elf.ucw.cz>
	 <200403240748.31837.dtor_core@ameritech.net>
	 <20040324151831.GB25738@atrey.karlin.mff.cuni.cz>
	 <20040324202259.GJ20333@jsambrook> <opr5dwwgzi4evsfm@smtp.pacific.net.th>
	 <20040325221348.GB2179@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080250397.6679.28.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Fri, 26 Mar 2004 09:33:17 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

On Fri, 2004-03-26 at 10:13, Pavel Machek wrote:
> swsusp1 fails your test, swsusp2 fails your test, and pmdisk fails it,
> too. If half of memory is used by kmalloc(), there's no sane way to
> make suspend-to-disk working. And swsusp[12] does not. Granted, half
> of memory kmalloc-ed is unusual situation, but it can theoreticaly
> happen. Try mem=8M or something.

Of course if you do have 8M memory, you're not going to care about
suspending to disk anyway :>. Note too that suspend2 will eat memory
until it can suspend. It doesn't livelock because it grabs the memory it
frees immediately and if it can't free enough, it gives up and exits
cleanly. You'll know almost instantly if your suspend is going to
succeed or fail: once you start seeing the image written, the only thing
that will stop it is media/hardware failure or user intervention.

> > Right, because nobody pays attention. If you step on the brake pedal driving
> > your car these brakes better work or you may be well worse of than dead
> > ... just in case you ran over a kid...
> 
> So don't put swsusp into car-braking system.

LOL! Or M$!

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

