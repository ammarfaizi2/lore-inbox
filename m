Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbTEHHhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 03:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbTEHHhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 03:37:39 -0400
Received: from mail.convergence.de ([212.84.236.4]:56210 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261156AbTEHHhi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 03:37:38 -0400
Message-ID: <3EBA0C35.8060104@convergence.de>
Date: Thu, 08 May 2003 09:50:13 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Monchi Abbad <kernel@axion.demon.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: dvb-tuner ves1820 not working since linux-2.5.68
References: <20030507172257.GB783@axion.demon.nl>
In-Reply-To: <20030507172257.GB783@axion.demon.nl>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Monchi,

thanks for your report!

> From kernel 2.5.68 on when dvb tuner driver ves1820 is
 > compiled in the kernel freezes up upon init of ves1820 driver.#
 > When compiled as module the system doesn't freeze but the driver
 > segfaults on load (see attachments). In kernel 2.5.67-bk3 no problems.

A new saa7146 subsystem was added plus all device drivers and frontend 
drivers have been improved. It's possible that something was broken in 
the migration.

I'll try and reproduce your crash. In the meantime, you could use the 
"dvb-kernel" tree from the linuxtv.org CVS, patch your 2.5 kernel with 
it (via the "makelinks" script") and try to compile with the new drivers.

> Monchi.

One note: you should send your bug-reports at least with a CC to the 
linux-dvb kernel mailing list, otherwise the DVB folks might miss it.

http://www.linuxtv.org/mailinglists.xml

CU
Michael.


