Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbUKJMsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUKJMsg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbUKJMsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:48:36 -0500
Received: from shinjuku.zaphods.net ([194.97.108.52]:29662 "EHLO
	shinjuku.zaphods.net") by vger.kernel.org with ESMTP
	id S261797AbUKJMsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:48:32 -0500
Date: Wed, 10 Nov 2004 13:48:11 +0100
From: Stefan Schmidt <zaphodb@zaphods.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110124810.GG28163@zaphods.net>
References: <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org> <20041110020327.GE20754@zaphods.net> <419197EA.9090809@cyberone.com.au> <20041110102854.GI20754@zaphods.net> <20041110120624.GF28163@zaphods.net> <20041110085831.GB10740@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110085831.GB10740@logos.cnet>
X-Origin-AS: AS5430
X-NCC-nic-hdl: ZAP-RIPE
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: zaphodb@zaphods.net
X-SA-Exim-Scanned: No (on shinjuku.zaphods.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 06:58:31AM -0200, Marcelo Tosatti wrote:
> > > > Can you try the following patch, please? It is diffed against 2.6.10-rc1,
> > I did. No apparent change with mm4 and vm.min_free_kbytes = 8192. I will try
> > latest bk next.

> > > I set it back to CONFIG_PACKET_MMAP=y and if the application does not freeze
> > > for some hours at this load we can blame at least this issue (-1 EAGAIN) on
> > > that parameter.
> > Nope, that didn't change anything, still getting EAGAIN, checked two times.
> Its not clear to me - do you have Nick's watermark patch in? 
Yes i have vm.min_free_kbytes=8192 and Nick's patch in mm4. I'll try
rc1-bk19 with his restore-atomic-buffer patch in a few minutes.

	Stefan
-- 
The reason computer chips are so small is computers don't eat much.
