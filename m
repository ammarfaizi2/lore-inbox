Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269829AbRH0XTF>; Mon, 27 Aug 2001 19:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRH0XS4>; Mon, 27 Aug 2001 19:18:56 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:55045 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269756AbRH0XSn>; Mon, 27 Aug 2001 19:18:43 -0400
Message-ID: <3B8AD317.D6434681@t-online.de>
Date: Tue, 28 Aug 2001 01:09:11 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: zaitcev@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: A tester is needed with dual P3 and USB
In-Reply-To: <20010827182204.A25212@devserv.devel.redhat.com> <20010828014211.A29068@netppl.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Pietikainen schrieb:
> 
> On Mon, Aug 27, 2001 at 06:22:04PM -0400, Pete Zaitcev wrote:
> > Hi, All:
> >
> > I received a complaint that a UP kernel hangs on boot if USB is
> > enabled. SMP works. An SMP kernel started with "nosmp" hangs too.
> > The reporter is, umm, how shall I put it... is a power user.
> > I need someone to help me to track the problem down, because
> > I am curious. I heard of SMP hangs before, but a UP hang is
> > a novel idea.
> >
> > The box is VA Linux 1000 (similar to IBM Netfinity 4000r).
> > Kernel is 2.4.8-ac10.
> Doesn't VA use one of those Intel boards which have the problem
> with theis BIOS, which is seen as a hang with the adaptec driver?

Thats the problem i can reproduce here (ASUS-P2B-DS with Dual PIII/850,
USB and AHA2940U2W-SCSI onboard, Kernel 2.4.2/3-SMP), SMP-Kernels with
option "nosmp" simply stop when they try to access the SCSI-System, the
aic7xxx-driver loads (no matter if build-in or module), but stucks at
initializing the first device.
No Ooop or crash, it simply does nothing any more.

But a "real" UP-Kernel (i used the one from RH7.1, 2.4.2-UP) has no
problems with booting here.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
... -.-

