Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbULXECW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbULXECW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 23:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULXECW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 23:02:22 -0500
Received: from smtpout3.compass.net.nz ([203.97.97.135]:58848 "EHLO
	smtpout1.compass.net.nz") by vger.kernel.org with ESMTP
	id S261364AbULXECR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 23:02:17 -0500
From: Steve Kieu <steve@perfectpc.co.nz>
Organization: PerfectPC Ltd.
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: rtc in 2.6.10rc3
Date: Fri, 24 Dec 2004 17:02:11 +1300
User-Agent: KMail/1.6.2
References: <Pine.LNX.4.60.0412241631220.513@localhost> <1103859934.13482.2.camel@krustophenia.net>
In-Reply-To: <1103859934.13482.2.camel@krustophenia.net>
Cc: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412241702.11286.steve@perfectpc.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 24 Dec 2004 16:45, you wrote:
> On Fri, 2004-12-24 at 16:33 +1300, steve@perfectpc.co.nz wrote:
> > Just do a 'modprobe rtc' with kernel 2.6.10rc3 and got the message No
> > such device of course VMware or mplayer can not use /dev/rtc.
> >
> > Things normal with 2.4.27 though. What did I miss or is this a known bug
> > in 2.6.10rc3?
>
> The RTC works fine.  You are doing something wrong.  Probably you didn't
> compile the kernel with RTC support.
>
> Lee

# ls /lib/modules/2.6.10-rc3p3_nopreempt/kernel/drivers/char/
dtlk.ko    hangcheck-timer.ko  lp.ko     ppdev.ko  tipar.ko
genrtc.ko  hw_random.ko        nvram.ko  rtc.ko    watchdog

clearly I got rtc.ko and genrtc.ko as well.

# grep RTC /home/linux-2.6/.config
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_SENSORS_RTC8564=m
CONFIG_SND_RTCTIMER=m
bash-2.05b# 


- -- 
S.KIEU
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBy5TDv07eUvBr8ysRAhKuAJ9V9H1XpbghnmxocDw8Evl1BhZ+HACfSnpb
ov+vR5M8b62Xcs9AGIGw6wI=
=goRJ
-----END PGP SIGNATURE-----
