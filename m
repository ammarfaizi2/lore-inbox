Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTI3AxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 20:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbTI3AxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 20:53:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:25520 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263098AbTI3AxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 20:53:02 -0400
Date: Mon, 29 Sep 2003 17:48:43 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@localhost.localdomain
To: Andreas Jellinghaus <aj@dungeon.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: pm: Revert swsusp to 2.6.0-test3
In-Reply-To: <pan.2003.09.30.00.43.13.7088@dungeon.inka.de>
Message-ID: <Pine.LNX.4.44.0309291747020.968-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are both versions compatible? How to resume the right version?
> Or simply resume=/dev/hda3 and the kernel will pick the right
> mechanism to resume? 

No, they are not compatible. The resume= command line parameter will be 
trapped by the swsusp code. When using pmdisk, you may set the partition 
you want to use for suspend/resume via the CONFIG_PMDISK_PARTITION 
compile-time option. Or, you may override that using the pmdisk= command 
line parameter. 

I realize it's a bit confusing, but I will write documentation that 
explicitly describes the differences within the week.


	Pat

