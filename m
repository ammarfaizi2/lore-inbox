Return-Path: <linux-kernel-owner+w=401wt.eu-S964921AbXAGTDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbXAGTDk (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 14:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbXAGTDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:03:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43350 "HELO
	viper.oldcity.dca.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964921AbXAGTDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:03:40 -0500
Subject: Re: [2.6.18.2] ide_core bug: kobject_add failed for ide ...
From: Lee Revell <rlrevell@joe-job.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <enrbhg$1m0$1@p54A18DCE.dip0.t-ipconnect.de>
References: <enrbhg$1m0$1@p54A18DCE.dip0.t-ipconnect.de>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 14:05:00 -0500
Message-Id: <1168196701.18788.69.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 18:44 +0100, Andreas Hartmann wrote:
> Hello,
> 
> ide_core is loaded (while putting in an USB stick) as module the first
> time after reboot - all works fine. The USB stick got mounted and a ls
> is done to show the files on the root of the filesystem of the stick.
> Afterwards, the stick is securely removed from the system.
> Afterwards, ide_core is unloaded with rmmod (after usb-storage has been
> unloaded) - ok.
> 
> Next step is to load ide_core again. Now, the following error can be
> found in /var/log/messages:
> 
> 
> Jan  7 11:48:18 notebook1 kernel: Uniform Multi-Platform E-IDE driver
> Revision: 7.00alpha2
> Jan  7 11:48:18 notebook1 kernel: ide: Assuming 33MHz system bus speed
> for PIO modes; override with idebus=xx
> Jan  7 11:48:18 notebook1 kernel: kobject_add failed for ide with
> -EEXIST, don't try to register things with the same name in the same
> directory.

You seem to be running a SuSE kernel - please report the issue to them.

It's probably useful to repeat your test but run "find /sys/module >
sys1" before loading ide_core the first time, then "find /sys/module >
sys2" after "rmmod ide_core", and save the output of "diff sys1 sys2".

Lee


