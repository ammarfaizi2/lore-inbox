Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267471AbUBSSe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 13:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUBSSeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 13:34:25 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:16906
	"EHLO muru.com") by vger.kernel.org with ESMTP id S267471AbUBSSdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 13:33:55 -0500
Date: Thu, 19 Feb 2004 10:34:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Intel x86-64 support patch breaks amd64
Message-ID: <20040219183448.GB8960@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I guess you probably already know about this, but the recent changeset
1.1561.1.1 breaks compiling and booting for amd64.

First, this breaks for the compile:

arch/x86_64/kernel/setup.c: In function detect_ht':
arch/x86_64/kernel/setup.c:599: error: smp_num_siblings' undeclared (first
use in this function)
arch/x86_64/kernel/setup.c:599: error: (Each undeclared identifier is
reported only once
arch/x86_64/kernel/setup.c:599: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
make: *** [arch/x86_64/kernel] Error 2

After #if 0 out some parts to make it compile, it fails to boot with no
output at all. Sorry, don't have low level debugging or serial console on 
this machine configured, let me know if you need further information.

Undoing this cset makes things work as before.

Regards,

Tony
