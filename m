Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbULTW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbULTW0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULTW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:26:37 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:57102 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261667AbULTW0d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:26:33 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Cyrix 6x86 Comma Bug 2.6
Date: Tue, 21 Dec 2004 00:26:17 +0200
User-Agent: KMail/1.5.4
References: <41C41A04.8030009@tiscali.de>
In-Reply-To: <41C41A04.8030009@tiscali.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412210026.17426.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 December 2004 13:52, Matthias-Christian Ott wrote:
> Hi!
> I have some problems with my Cyrix cpu it stop some times and ugly 
> tokens appear on the screen. Is the Comma Bug the reason (I test the 
> hdd, memory and pci cards -- they are all ok)? Is the comma bug "fixed"? 
> If not so, how to do this?

It is very unlikely that you see "Coma" bug. It can be triggered only
by deliberately coded tight endless loop. "Ugly tokens on the screen"
suggest that you see something else.

arch/i386/kernel/cpu/mtrr/changelog says:
    19990218   Zoltán Böszörményi <zboszor@mail.externet.hu>
               Remove Cyrix "coma bug" workaround from here.
               Moved to linux/arch/i386/kernel/setup.c and
               linux/include/asm-i386/bugs.h

but neither of those files mention "coma"...

PS: "coma" bug won't trigger if automatic locking of
xchg insn is disabled (yes, Cyrix can be configured to do this).
This shall be done for performance reasons too.
No SMP dangers since Cyrix CPUs aren't used in SMP...

So grep the source / google Inet for this if you are still interested.
--
vda

