Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVDWQZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVDWQZb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 12:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVDWQZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 12:25:31 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:41658 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261619AbVDWQZY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 12:25:24 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Shaun Jackman <sjackman@gmail.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: lirc and Linux 2.6.11
Date: Sat, 23 Apr 2005 17:24:34 +0100
User-Agent: KMail/1.8
References: <7f45d9390504211526277e83be@mail.gmail.com>
In-Reply-To: <7f45d9390504211526277e83be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504231724.34083.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 Apr 2005 23:26, Shaun Jackman wrote:
> I was using lirc 0.7.0 with Linux 2.6.8.1. Upon upgrading to Linux
> 2.6.11, I recompiled the lirc 0.7.0 hauppauge (lirc_i2c) modules for
> the new kernel. This did not work. I then tried compiling the lirc
> 0.7.1 modules for the new kernel. This didn't work either. The error
> message lircd gives is...
>
> Apr 21 14:57:29 quince lircd 0.7.1: lircd(hauppauge) ready
> Apr 21 14:57:52 quince lircd 0.7.1: accepted new client on /dev/lircd
> Apr 21 14:57:52 quince lircd 0.7.1: could not open /dev/lirc0
> Apr 21 14:57:52 quince lircd 0.7.1: default_init(): No such device
> Apr 21 14:57:52 quince lircd 0.7.1: caught signal
>
> I've also asked the lirc mailing list this question, but has anyone
> else run into this trouble with lirc and Linux 2.6.11?
>

lirc works fine here. Try rebooting, the makefile mknods some arbitrary device 
nodes even if you're running devfs or udev, and in my experience they are 
broken. If you reboot it usually fixes them. I'm using lirc_i2c with my wintv 
remote, which I guess is the same as you.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
