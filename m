Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTEXObk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 10:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbTEXObk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 10:31:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:62939 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262042AbTEXObi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 10:31:38 -0400
Message-ID: <3ECF8559.5050209@gmx.net>
Date: Sat, 24 May 2003 16:44:41 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Rafa=B3_=27rmrmg=27_Roszak?= <rmrmg@wp.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [isdn] avm fritz pci
References: <20030519134546.4c4395bf.rmrmg@wp.pl> <20030524082545.2d1cbdc2.rmrmg@wp.pl>
In-Reply-To: <20030524082545.2d1cbdc2.rmrmg@wp.pl>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafa³ 'rmrmg' Roszak wrote:
> begin Rafa³ 'rmrmg' Roszak <rmrmg@wp.pl> quote:
> 
> 
>>I have kernel 2.4.21-rc2  (I also tested 2.4.20 2.4.21-pre6, pre7 and
>>rc1) and when I use 2 channels connect, system crash. Hisax modul is
>>loaded with parametrs: 
>>modprobe hisax protocol=2 type=27
>>
> 
>  
> I have this problem also in 2.4.21-rc3
> I compilded kernel with MAGIC_SYSRQ but I can't reboot system after
> crash use Alt+PrtScr+[s,u,b] ...

Did you enable SysRq with
echo 1 >/proc/sys/kernel/sysrq
If so, can you test if sysrq works while the system is not crashed?

In case SysRq doesn't work only after this crash, can you compile in the
NMI watchdog and boot with parameter
nmi_watchdog=1
That should print a backtrace if your system hangs hard and SysRq does
not work.
NOTE 1: You can see the backtrace only if you are not using X at that time.
NOTE 2: Your system will be dead after the NMI watchdog triggers. Please
write down the backtrace and pass it through ksymoops.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

