Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTLWAn3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTLWAn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:43:29 -0500
Received: from pop.gmx.de ([213.165.64.20]:60579 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264898AbTLWAnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:43:22 -0500
X-Authenticated: #15936885
Message-ID: <3FE78F98.4040304@gmx.net>
Date: Tue, 23 Dec 2003 01:43:04 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: netdev@oss.sgi.com, Manfred Spraul <manfred@colorfullife.com>
Subject: forcedeth: version 0.20 available
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

version 0.20 of forcedeth (GPLed nvnet replacement for nForce
on-board nics) for Linux 2.4 and 2.6 is available at
http://www.hailfinger.org/carldani/linux/patches/forcedeth/
It is also integrated in current -mm patchset and the 2.6
experimental net driver queue.
I will make precompiled modules available at the above address
as time permits.

Fixes in this release over 0.18:
* Work around bogus MAC addresses. Please report your exact
  hardware version/manufacturer if you hit this issue since
  NVidia has stated this should never happen and they are
  interested in any cases where it happens.
* Under extremely high network load on nForce3 systems, the
  nic won't lock up or slow down any more.

Known issues:
* Some nForce versions will report every received packet as
  1500 bytes long and fool RX statistics. This is definitely
  a hardware bug and we intend to provide a workaround in v0.21
* nForce3 systems are programmed to an incredibly high interrupt
  rate. We still need to find out what value to write to the
  timer register and we intend to fix this in v0.21
* "eth0: received irq with unknown events 0x<something>.
  Please report" might show up in your logs. That means we
  didn't encounter such an event during development and can
  only guess about its meaning.
  Please tell us what you were doing when the message appeared,
  how often it appeared and if it affects behaviour of your
  machine negatively.

Please test.


Regards,
Carl-Daniel

