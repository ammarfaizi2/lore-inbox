Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWCWKHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWCWKHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 05:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWCWKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 05:07:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53131 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751048AbWCWKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 05:07:17 -0500
Subject: Re: raw I/O support for Fedora Core 4
From: Arjan van de Ven <arjan@infradead.org>
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <WM57DB3DF98115400697C908A54A80DEE9@spsoftindia.com>
References: <WM57DB3DF98115400697C908A54A80DEE9@spsoftindia.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 11:07:15 +0100
Message-Id: <1143108435.3147.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 14:54 +0530, Yogesh Pahilwan wrote:
> Hi All,
> 
> I want to do raw I/O on MD RAID and LVM for fedora core 4(kernel 2.6.15.6).
> 
> After doing googling I came to know that "raw" command does the raw
> operation by linking 
> MD device and LVM volume to the raw device as 
> 
> # raw /dev/raw/raw1 /dev/md0.
> 
> But when I search on this I came to know that there is no raw (/dev/rawctl)
> device support available with 2.6 kernel.
> I have also tried recompile the kernel sources with raw device support it is
> not getting compiled as it is obsolete in 2.6. 
> If I want to include raw device support in my kernel what should I will have
> to do, so that I 

the preferred interface is doing O_DIRECT io on the device node itself,
rather than going via a (slower) indirection layer such as "raw". ("raw"
is just a wrapper on top of O_DIRECT basically in 2.6 kernels so slower)

