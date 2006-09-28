Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWI1Mff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWI1Mff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWI1Mfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 08:35:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:734 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751873AbWI1Mfe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 08:35:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Bernd Schmidt <bernds_cb1@t-online.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Thu, 28 Sep 2006 14:35:01 +0200
User-Agent: KMail/1.9.4
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, luke Yang <luke.adi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <6.1.1.1.0.20060927121508.01ecea90@ptg1.spd.analog.com> <200609281304.31872.arnd@arndb.de> <451BB45C.2050609@t-online.de>
In-Reply-To: <451BB45C.2050609@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609281435.02847.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 September 2006 13:39, Bernd Schmidt wrote:
> 
> > Shouldn't you just use a constant expression here? A global variable
> > for it sounds rather strange, especially since the local_irq_disable()
> > calls are sometimes nested, not to mention the problems you'd hit on
> > SMP?
> 
> It's not a constant - there are some {un,}mask_irq functions that may 
> change it.  We don't have SMP, obviously it would have to be per-CPU if 
> we did.
> 
Ok, got it now. I did not realize that you use the same register
for global irq enable and for specific interrupts that can be masked.

	Arnd <><
