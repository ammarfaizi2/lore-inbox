Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUGVEu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUGVEu5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 00:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUGVEu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 00:50:57 -0400
Received: from sev.net.ua ([212.86.233.226]:44549 "EHLO sev.net.ua")
	by vger.kernel.org with ESMTP id S266692AbUGVEuz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 00:50:55 -0400
Subject: Re: kernel 2.4.26 oops (maybe solved)
From: Alex Lyashkov <shadow@psoft.net>
To: psantoro@att.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40FF33DE.6010307@att.net>
References: <40FF33DE.6010307@att.net>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Organization: PSoft
Message-Id: <1090471849.7877.3.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 22 Jul 2004 07:50:50 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Чтв, 22.07.2004, в 06:26, Peter Santoro пишет:
> After trying many h/w and s/w configurations, I've apparently isolated 
> my instability issues to using the following the linux kernel highmem 
> options: CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y, CONFIG_HIGHMEMIO=y.  I 
> have 1GB ram, so maybe one of my dimms is bad or maybe there's a highmem 
> bug in the 2.4.X kernel.
> 
> The crashes in my previous emails today were due to using the latest 
> alsa modules (loaded, but not used by any application) with a HIGHMEM 
> enabled kernel.  I appear to have no problem using alsa when HIGHMEM is 
> disabled.  Apparently, I'm not the only one having problems with alsa 
> and highmem 
> (http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg13918.html).
> 
> I would be willing to work with a kernel developer to better isolate 
> this problem and test a patch.
> 
> Thank you,
> 
> 
> Peter Santoro
> -
sound like bad work with pte mapping. As possible use pte_*_map without
pte_unmap or same.
 

-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
