Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267570AbUBSVRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267321AbUBSVRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:17:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:44759 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267386AbUBSVP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:15:57 -0500
Date: Thu, 19 Feb 2004 13:08:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Carlos Silva" <r3pek@r3pek.homelinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hot kernel change
Message-Id: <20040219130808.0eab897e.rddunlap@osdl.org>
In-Reply-To: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org>
References: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 13:33:43 -0000 (WET) "Carlos Silva" <r3pek@r3pek.homelinux.org> wrote:

| hi,
| 
| i would like to know if isn't it possible to implement a hot kernel
| change, i mean, without reboot. i would do it myself if i had the knoledge
| to do it but i'm starting with kernel-level programing now. i think it
| would be possible if we make something like M$'s OS do when it hibernates,
| copy all the memory, registers, etc to the disc and then put all back
| again.
| 
| am i dreaming or this is possible? :)

The kexec patch is basically "linux reboots linux".
It bypasses the firmware/BIOS to do the reboot.

Patches for 2.6.0 and 2.6.1 are here (I haven't updated for
2.6.2 or 2.6.3 yet):
  http://developer.osdl.org/rddunlap/kexec/

Patches for some 2.5.x kernels are here:
  http://www.xmission.com/~ebiederm/files/kexec/

kexec does reduce reboot time quite a bit on some machines, but
there is still a noticeable pause.

--
~Randy
