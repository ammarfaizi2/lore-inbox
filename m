Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268181AbRGWKtA>; Mon, 23 Jul 2001 06:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268183AbRGWKsu>; Mon, 23 Jul 2001 06:48:50 -0400
Received: from ns.caldera.de ([212.34.180.1]:22993 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S268182AbRGWKsd>;
	Mon, 23 Jul 2001 06:48:33 -0400
Date: Mon, 23 Jul 2001 12:48:16 +0200
Message-Id: <200107231048.f6NAmG326835@ns.caldera.de>
From: hch@calder.de (Christoph Hellwig)
To: barbacha@Hinako.AMBusiness.com ("Anthony Barbachan")
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on porting 2.2.x driver to 2.4.x (reference namei)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <010201c1131d$7359d150$9865fea9@optima>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <010201c1131d$7359d150$9865fea9@optima> you wrote:
> Hi all,
>
>     I'm trying to port iBCS to the 2.4.x kernels.  One of the compile
> problems I've run into is that the 2.4.x kernel includes lack a namei()
> function definition.  I figure this function has been removed however what
> is its replacement?  Or at least how do I replace its functionality?  The
> section of code in iBCS in which this is used looks like this:
>
> dentry = namei(path);
> error = PTR_ERR(dentry);
>
> if (!IS_ERR(dentry)) {

Take a look at linux-abi (ftp.openlinux.org:/pub/people/hch/linux-abi),
specificly the file abi/svr4/xstat.c to see how to replace namei.

	Christoph

P.S. linux-abi does for 2.4 for iBCS did for 2.2 - and more
-- 
Whip me.  Beat me.  Make me maintain AIX.
