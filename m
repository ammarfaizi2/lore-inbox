Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbULGRLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbULGRLk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbULGRLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:11:39 -0500
Received: from mail.tmr.com ([216.238.38.203]:25608 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261849AbULGRLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:11:22 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: growisofs / system load / dma setting
Date: Tue, 07 Dec 2004 12:12:13 -0500
Organization: TMR Associates, Inc
Message-ID: <41B5E46D.5020204@tmr.com>
References: <33560.194.39.131.40.1101824878.squirrel@noto.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1102438924 30611 192.168.12.100 (7 Dec 2004 17:02:04 GMT)
X-Complaints-To: abuse@tmr.com
Cc: linux-kernel@vger.kernel.org
To: Thomas Fritzsche <tf@noto.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <33560.194.39.131.40.1101824878.squirrel@noto.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Fritzsche wrote:
> Hi Linux-Hackers,
> 
> I posted this message first to the cdwriter mailing list (
> http://www.mail-archive.com/cdwrite%40other.debian.org/msg07041.html )
> but they told me this is a kernel problem, thus I post it here again.
> Because I had this DVD-Device running without problem in 2.6.8 I can
> exclude that it's a cabel/hw-problem.
> 
> Thanks and regards,
>  Thomas Fritzsche
> ---------------------------------------
> Hi all,
> 
> I'm using growisofs -Z /dev/hdc=/link/to/iso.iso to burn DVD-Video's. This
> works, BUT the system load is very high while burning. I'l checked DMA
> setting but DMA is on (and 32 bit). I googled around but can not find a
> solution. I tried again and found that after burning dma is off!? I
> checked dmesg and found message:
> --------------------------------------
> hdc: irq timeout: status=0xd0 { Busy }
> hdc: irq timeout: error=0xd0LastFailedSense 0x0d
> hdc: DMA disabled
> hdc: ATAPI reset complete
> --------------------------------------
> I tested a few times and sometimes only the system load is very high but
> DMA  is still set after the run, but often DMA setting is disabled and I
> get the message above.
> 
> My system configuration is:
> 
> uname -a
> Linux vdr.noto.de 2.4.27-ctvdr-1 #1 Fri Oct 15 18:38:29 UTC 2004 i686
> GNU/Linux
> 
> hdparm -i /dev/hdc
> 
> 
> /dev/hdc:
> 
>  Model=_NEC DVD_RW ND-3500AG, FwRev=2.16, SerialNo=
>  Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
>  RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=unknown, BuffSize=0kB, MaxMultSect=0
>  (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
>  IORDY=yes, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 *udma2
>  AdvancedPM=no
> 
>  * signifies the current active mode
> 
> ------------------------------
> 
> Is this a growisofs problem or a kernel problem? What causes this trouble?
> What can I do to avoid this problems.

Do you have any automounter daemon running? All the window managers are 
really bad about this, even when told not to do that, they do (under 
some conditions I haven't isolated).

Try it running with X down (console mode). If the problem goes away you 
have a start, if not track the system with "vmstat 1" and post a screen 
or two.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
