Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272267AbTHRTCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 15:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272242AbTHRTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 15:02:53 -0400
Received: from [216.52.22.10] ([216.52.22.10]:16617 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S272231AbTHRTCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 15:02:51 -0400
Date: Mon, 18 Aug 2003 13:04:12 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stefan Foerster <stefan@stefan-foerster.de>, linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-ID: <1294265408.1061233452@aslan.btc.adaptec.com>
In-Reply-To: <20030818013243.GB21665@in-ws-001.cid-net.de>
References: <20030818013243.GB21665@in-ws-001.cid-net.de>
X-Mailer: Mulberry/3.1.0b5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But as soon as I do a
> 
> while true; do dd if=/dev/zero of=test bs=1024 count=1048576 ; rm test
> ; done
> 
> on my SCSI disk, the system becomes completely unusuable after a few
> seconds. Everything is running at the speed of molasses, even screen
> redrawing, the music stops playing for some seconds, my mouse hangs
> and so on.

It sounds like the system is not limiting the rate at which an I/O
hog can dirty pages, so this one process ends up consuming all of
your I/O bandwidth.

--
Justin

