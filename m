Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTJFS3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbTJFS3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:29:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:59318 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262164AbTJFS3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:29:00 -0400
Date: Mon, 6 Oct 2003 11:20:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dag Nygren <dag@newtech.fi>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Bug in the sg driver
Message-Id: <20031006112028.1242199d.rddunlap@osdl.org>
In-Reply-To: <20031006180636.16530.qmail@dag.newtech.fi>
References: <20031006180636.16530.qmail@dag.newtech.fi>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Oct 2003 21:06:36 +0300 Dag Nygren <dag@newtech.fi> wrote:

| 
| Hi,
| 
| just got back from a customer with major problems
| with a LTO-drive and an Adaptec 19160.
| 
| The problems was ones that HP claimed a firmware
| upgrade would fix and even gave a tool for doing this:
| hp_ltt.
| 
| Running this the first time would always segfault and trying
| a second time would consistently panic the system.
| 
| We traced the segfault to sg_ioctl trying to do something.
| After finding a vague hint with google I tried to boot with
| mem=512M (The machine has 2GB of memory) and voila:
| The update worked without any crashes.
| We don't know yet if the firmware update fixed the original problem,
| but the conclusion is:
| 
| sg_ioctl seems to address illegal parts of memory when used with
| kernels where highmem is enabled.
| 
| Any sg-driver maintainers out there?


from MAINTAINERS file:
SCSI SG DRIVER
P:	Doug Gilbert
M:	dgilbert@interlog.com
L:	linux-scsi@vger.kernel.org
W:	http://www.torque.net/sg
S:	Maintained


Any details, like kernel version, oops or panic logs, etc.?

--
~Randy
