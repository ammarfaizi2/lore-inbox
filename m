Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbTGHPM0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTGHPLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:11:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:26796
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S267364AbTGHPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:10:28 -0400
Subject: Re: Question regarding DMA xfer to user space directly
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Shih <alan@storlinksemi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ODEIIOAOPGGCDIKEOPILIEODCLAA.alan@storlinksemi.com>
References: <ODEIIOAOPGGCDIKEOPILIEODCLAA.alan@storlinksemi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057677742.4358.36.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jul 2003 16:22:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-08 at 15:50, Alan Shih wrote:
> Is there a provision in MM for DMA transfer to user space directly without
> allocating a kernel buffer?

Yes. Its used both for O_DIRECT I/O (direct to disk I/O from userspace)
and for things like tv capture cards. The kernel allows a driver to pin
user pages and obtain mappings for them. Note that for large systems 
user pages may be above the 32bit boundary so you need DAC capable
hardware to get the best results

