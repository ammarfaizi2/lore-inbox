Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVAOROp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVAOROp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 12:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVAOROp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 12:14:45 -0500
Received: from [195.110.122.101] ([195.110.122.101]:8845 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S262302AbVAOROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 12:14:42 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] I2C: Allow it87 pwm reconfiguration
Date: Sat, 15 Jan 2005 18:18:25 +0100
User-Agent: KMail/1.7.2
Cc: Greg KH <greg@kroah.com>, "Jonas Munsin" <jmunsin@iki.fi>, djg@pdp8.net
References: <20050113232904.GC2458@kroah.com> <g7Idbr9m.1105713630.9207120.khali@localhost> <20050115163045.2e636632.khali@linux-fr.org>
In-Reply-To: <20050115163045.2e636632.khali@linux-fr.org>
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501151818.27227.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 January 2005 16:30, Jean Delvare wrote:

> Simone, feel free to test this (on top of 2.6.11-rc1-mm1 for example).

I've been unable to apply your patch cleanly on top of 2.6.11-rc1-mm1, but 
eventually I've managed to apply it manually.

I can confirm it works as expected.

Without parameters I get in dmesg:

  it87: Found IT8705F chip at 0x290, revision 2
  it87 0-0290: Detected broken BIOS defaults, disabling PWM interface

No pwm appears in sysfs and the missing linefeed has been fixed

Adding "options it87 fix_pwm_polarity=1" in modules.conf I get:

  it87: Found IT8705F chip at 0x290, revision 2
  it87 0-0290: Reconfiguring PWM to active high polarity

PWM controllers appear in sysfs, the fan doesn't stop running at load time and 
pwm values are now in normal direction: (0 stops, 255 runs full-speed).

Thanks!

/Simone

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org

