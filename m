Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUAEMeN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbUAEMeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:34:12 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:688 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264391AbUAEMeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:34:06 -0500
Subject: Re: Kernel panic.. in 3.0 Enterprise Linux
From: Christophe Saout <christophe@saout.de>
To: Rik van Riel <riel@redhat.com>
Cc: neel vanan <neelvanan@yahoo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0401050722520.23604-100000@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.44.0401050722520.23604-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1073306020.5755.5.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 13:33:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 05.01.2004 schrieb Rik van Riel um 13:23:

> On Mon, 5 Jan 2004, Christophe Saout wrote:
> >
> > LABEL= is a RedHat extension. Please use the normal root options that is
> > described in the Grub or kernel documentation.
> 
> It's not even a Red Hat extension.  The LABEL= stuff is
> done entirely in userspace, on the initrd.

I was misinformed then. Thanks.

> RAMDISK: Compressed image found at block 0
> RAMDISK: incomplete write (-1 !=32768) 4194304
> VFS cannot open root device "LABEL=/" or unknown block (0,0)

His initrd can't be correctly loaded. It seems the initrd is larger than
4MiB but he didn't increase the maximum size in the kernel
configuration.


