Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbUKJMY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUKJMY3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUKJMY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:24:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25018 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261705AbUKJMY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:24:27 -0500
Date: Wed, 10 Nov 2004 06:58:31 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Stefan Schmidt <zaphodb@zaphods.net>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.10-rc1-mm4 -1 EAGAIN after allocation failure was: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041110085831.GB10740@logos.cnet>
References: <20041109164113.GD7632@logos.cnet> <20041109223558.GR1309@mail.muni.cz> <20041109144607.2950a41a.akpm@osdl.org> <20041109235201.GC20754@zaphods.net> <20041110012733.GD20754@zaphods.net> <20041109173920.08746dbd.akpm@osdl.org> <20041110020327.GE20754@zaphods.net> <419197EA.9090809@cyberone.com.au> <20041110102854.GI20754@zaphods.net> <20041110120624.GF28163@zaphods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110120624.GF28163@zaphods.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2004 at 01:06:24PM +0100, Stefan Schmidt wrote:
> On Wed, Nov 10, 2004 at 11:28:54AM +0100, Stefan Schmidt wrote:
> > > Can you try the following patch, please? It is diffed against 2.6.10-rc1,
> > > but I think it should apply to -mm kernels as well.
> I did. No apparent change with mm4 and vm.min_free_kbytes = 8192. I will try
> latest bk next.
> 
> > I unset CONFIG_PACKET_MMAP and i suppose this could have this kind of effect
> > on high connection rates.
> > I set it back to CONFIG_PACKET_MMAP=y and if the application does not freeze
> > for some hours at this load we can blame at least this issue (-1 EAGAIN) on
> > that parameter.
> Nope, that didn't change anything, still getting EAGAIN, checked two times.

Hi Stefan,

Its not clear to me - do you have Nick's watermark patch in? 
