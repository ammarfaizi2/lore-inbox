Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289231AbSA1Qqe>; Mon, 28 Jan 2002 11:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289236AbSA1QqW>; Mon, 28 Jan 2002 11:46:22 -0500
Received: from jhuml3.jhu.edu ([128.220.2.66]:20884 "HELO jhuml3.jhu.edu")
	by vger.kernel.org with SMTP id <S289231AbSA1QqG>;
	Mon, 28 Jan 2002 11:46:06 -0500
Date: Mon, 28 Jan 2002 11:19:58 -0500
From: Thomas Hood <jdthood@mail.com>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <E16VBgH-0000Z4-00@the-village.bc.nu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Message-id: <1012234798.744.103.camel@thanatos>
MIME-version: 1.0
X-Mailer: Evolution/1.0.1
Content-type: text/plain
Content-transfer-encoding: 7bit
In-Reply-To: <E16VBgH-0000Z4-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-28 at 08:18, Alan Cox wrote:
> We don't know how VMware switches between virtual machines. If that
> switch is done behind Linux back, then VMware is effectively special.
> It is virtualising the system and it has to virtualise APM status too.
> If its doing the switch when it is a current foreground process then
> it wouldnt explain the problem

VMware is essentially a hardware emulator, so if the guest OS is
idling the CPU it should only be idling the virtual CPU, not the
real one.  

Having said that, VMware emulates a lot of hardware by making
use of facilities that Linux provides.  It emulates a super-VGA
card by making use of X, for example.  Do you suppose that
VMware emulates CPU slowing by slowing the real CPU?  I hope not.

Since VMware is closed source software we needn't worry our
heads too much about this problem.  VMware users have a 
workaround: set idle_threshold to 100.

Can we get more info about the keyboard repeat rate slowing?

--
Thomas

