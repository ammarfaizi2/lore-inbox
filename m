Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317366AbSINQYW>; Sat, 14 Sep 2002 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSINQYW>; Sat, 14 Sep 2002 12:24:22 -0400
Received: from adsl-64-168-240-37.dsl.sntc01.pacbell.net ([64.168.240.37]:21230
	"EHLO adsl-64-168-240-37.dsl.sntc01.pacbell.net") by vger.kernel.org
	with ESMTP id <S317366AbSINQYW>; Sat, 14 Sep 2002 12:24:22 -0400
Date: Sat, 14 Sep 2002 09:42:25 -0700
From: Brian Craft <bcboy@thecraftstudio.com>
To: linux-kernel@vger.kernel.org
Subject: delay before open() works
Message-ID: <20020914094225.A1267@porky.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -- I notice in 2.4 kernels that there's a delay between completion of
"modprobe scanner" and when the device file can be successfully opened. I'm
working on code to power-up devices on-demand.

I've played some with making scripts to work around this, like

  heyu turn on scanner
  modprobe scanner
  sleep 15
  xsane

This is pretty gross, since I have to determine the "15" by playing with it,
and I'm sure it will fail some of the time unless I make it reeeeeally long. I
suspected this was some hardware issue -- USB latencies on device discovery, or
boot time for the scanner -- but a friend who isn't attempting to power-up his
devices says he sees the same behavior when just scripting "modprobe". So it
appears there's some fairly long delay in the kernel itself.

Anyone know off-hand what causes this delay, or if there's some way to get
the open() to block?

(btw, I'm not subscribed to the list).
b.c.
