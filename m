Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUBIIYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBIIYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:24:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:39820 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264372AbUBIIYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:24:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16423.17315.777835.128816@alkaid.it.uu.se>
Date: Mon, 9 Feb 2004 09:24:03 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: wrlk@riede.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Selective attach for ide-scsi
In-Reply-To: <20040208224248.GA28026@serve.riede.org>
References: <20040208224248.GA28026@serve.riede.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willem Riede writes:
 > Today, if you boot 2.6.x with hdd=ide-scsi, ide-scsi will attach to
 > all your Atapi drives, not just hdd, unless you explicitely specified
 > another driver for those.
 > 
 > Given that we don't want people to use ide-scsi for cdroms and cd-writers,
 > that behavior is IMHO suboptimal.
 > 
 > The patch below makes ide-scsi attach ONLY to those drives that you tell
 > it to. So if you want it to handle hdb and hdd, but not hdc, you boot
 > with hdb=ide-scsi hdd=ide-scsi.

The patch I posted, which you apparently didn't like, doesn't
require the use of boot-only options: it instead adds a module_param
to ide-scsi which allows for greater flexibility.

Personally I never liked that butt-ugly hdX=ide-scsi hack.

/Mikael
