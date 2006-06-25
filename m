Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWFYJPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWFYJPw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 05:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWFYJPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 05:15:51 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:42975 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932144AbWFYJPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 05:15:51 -0400
Message-ID: <449E5445.60008@free.fr>
Date: Sun, 25 Jun 2006 11:15:49 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, htejun@gmail.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: + via-pata-controller-xfer-fixes.patch added to -mm tree
References: <200606242214.k5OMEHCU005963@shell0.pdx.osdl.net> <449DBE88.5020809@garzik.org> <449DBFFD.2010700@garzik.org>
In-Reply-To: <449DBFFD.2010700@garzik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Data point #3 (or #0...):
> 
> This appears to be a _device_ that sends its interrupt early.
> 
> If that is the case, the device may appear on any controller, not just 
> VIA, and we would have to handle it globally via a device special-case 
> in libata-core.
> 

For the record, the cdrom writer that need this quirk on pata via, works 
on pata sil680.
But 3 microsecond is very short, and the problem could be hidden by the 
controller, or other stuffs.


