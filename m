Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVBGKNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVBGKNj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 05:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVBGKNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 05:13:39 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:27313 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261392AbVBGKNe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 05:13:34 -0500
Subject: Re: How to read file in kernel module?
From: Marcel Holtmann <marcel@holtmann.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux lover <linux_lover2004@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107758316.3886.58.camel@laptopd505.fenrus.org>
References: <20050207061718.47940.qmail@web52203.mail.yahoo.com>
	 <1107758316.3886.58.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 11:13:24 +0100
Message-Id: <1107771204.7327.62.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >         I have written one /proc file creation kernel
> > module. This module creates /proc/file and defied
> > operations on it. Also i have written user program
> > that will read & write to /proc files from user space.
> > Now what i want is to use same bufproc_read &
> > bufproc_write  functions defined in /proc file
> > handling kernel module to be used in another kernel
> > module to read that /proc/file in kernel module.The
> > second kernel module only used to read /proc file in
> > kernel. I am not understanding how can i open that
> > /proc/file in second kenrel module to read in kernel?
> > regards,
> 
> the answer really is that you should not read files from kernel
> modules; /proc or otherwise.

the only thing that is may needed by a kernel driver should be an
external firmware file and for that we have request_firmware(). For
everything else you are on the wrong track.

Regards

Marcel


