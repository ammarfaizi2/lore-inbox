Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277368AbRJJTSy>; Wed, 10 Oct 2001 15:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277372AbRJJTSq>; Wed, 10 Oct 2001 15:18:46 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:62357 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277369AbRJJTSg>; Wed, 10 Oct 2001 15:18:36 -0400
Subject: Re: 2.4.11 APIC problems
From: Paul Larson <plars@austin.ibm.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1979423952.1002706803@mbligh.des.sequent.com>
In-Reply-To: <1979423952.1002706803@mbligh.des.sequent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 10 Oct 2001 14:24:05 +0000
Message-Id: <1002723849.29152.15.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-10-10 at 16:40, Martin J. Bligh wrote:
> If you look at the VGA screen, what are the final messages before
> "APIC error on CPU0: 08(08)" ? You might want to add a "die()"
> call at the end of arch/i386/kernel/apic.c:smp_error_interrupt()
Looking at the vga screen without console-serial going on, I just saw an
endless stream of those errors.  With console getting logged over the
serial line though, I would see the same random garbage in the output I
sent you earlier, and not see the error message.

So, I tried inserting the die() like you said without console serial.  I
got pagefulls of dumps and pretty soon it rebooted itself.  So, I logged
to the serial console again on the next reboot to capture the output. 
Looks like we got the "APIC error" message in the log too.  It's a
really long log so I attached it rather than putting it inline.

Thanks,
Paul Larson

