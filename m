Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTEXSbR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 14:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTEXSbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 14:31:17 -0400
Received: from pop.gmx.net ([213.165.65.60]:23112 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262627AbTEXSbQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 14:31:16 -0400
Message-ID: <3ECFBD82.60503@gmx.net>
Date: Sat, 24 May 2003 20:44:18 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Rafa=5E=283=29_=27rmrmg=27_Roszak?= <rmrmg@wp.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [isdn] avm fritz pci
References: <20030519134546.4c4395bf.rmrmg@wp.pl>	<20030524082545.2d1cbdc2.rmrmg@wp.pl>	<3ECF8559.5050209@gmx.net> <20030524193144.34dcd6b4.rmrmg@wp.pl>
In-Reply-To: <20030524193144.34dcd6b4.rmrmg@wp.pl>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafa³ 'rmrmg' Roszak wrote:
> begin  Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
> quote:
> 
> 
>>Did you enable SysRq with
>>echo 1 >/proc/sys/kernel/sysrq
> 
> 
> default is 1 in this file
> 
> 
>>If so, can you test if sysrq works while the system is not crashed?
> 
> 
> yes, sysrq works  
> 
> 
>>In case SysRq doesn't work only after this crash, can you compile in
>>the NMI watchdog and boot with parameter
> 
> 
> sorry I can't find this in make menuconfig
> Could you help me?

It will be compiled in automatically if you select
"Local APIC Support on Uniprocessors" and "IO-APIC support on
uniprocessors", then boot with
nmi_watchdog=1

If your system hangs for longer than 5 seconds, the NMI watchdog will
print a backtrace on the console.


HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/

