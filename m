Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVCJLwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVCJLwd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 06:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVCJLwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 06:52:33 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:22520 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262530AbVCJLwb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 06:52:31 -0500
Date: Thu, 10 Mar 2005 12:50:08 +0100 (CET)
To: rbultje@ronald.bitfreak.net
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <cvxT6YRf.1110455408.1808270.khali@localhost>
In-Reply-To: <Pine.LNX.4.56.0503100141390.22284@www.ithos.nl>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Chris Wright" <chrisw@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Daniel Staaf" <dst@bostream.nu>, "LKML" <linux-kernel@vger.kernel.org>,
       "Andrei Mikhailovsky" <andrei@arhont.com>,
       "Ian Campbell" <icampbell@arcom.com>, "Gerd Knorr" <kraxel@bytesex.org>,
       stable@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ronald,

> I indeed don't test RC/MM kernels. I'm fairly happy with the current
> driver status, so I'm not doing any active new development on it. I run
> standard Fedora kernels with CVS of the driver (which is the same as
> what's in 2.6.10).
> (...)
> My experience is not the same as yours, it seems... I cannot explain why,
> unfortunately. (...)

I can. You are using a 2.6.10 kernel at best (that's what FC3 updates
have), and the bug is triggered by changes made to the i2c-algo-bit
driver somewhere between 2.6.10 and 2.6.11. So it's not surprising that
you don't see any problem. Note that the version of the media/video
drivers you use is not relevant here. The bug has been there for over a
year, but the code path where it lies was never taken until i2c-algo-bit
was updated recently. What matters is the version of i2c-algo-bit.

So as long as you don't move to a 2.6.11 kernel, don't even bother
trying my patches, because you will never hit the code that I am trying
to fix.

Thanks,
--
Jean Delvare
