Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUEWNPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUEWNPs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 09:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbUEWNPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 09:15:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262837AbUEWNPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 09:15:47 -0400
Date: Sun, 23 May 2004 09:15:12 -0400
From: Alan Cox <alan@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Alan Cox <alan@redhat.com>, Christoph Hellwig <hch@alpha.home.local>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
Message-ID: <20040523131512.GA25185@devserv.devel.redhat.com>
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local> <20040523110836.GE25746@devserv.devel.redhat.com> <20040523115735.GA16726@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040523115735.GA16726@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there a reason btw it can't be done with LD_PRELOAD ?
> 
> Well, this is an interesting question. I don't know how to do it this way
> (how can a program know exactly where the trap occured, etc... I don't know
> how to program this). Other than that, LD_PRELOAD will not work against setuid
> binaries. But if it does for the rest, I think it can become an elegant
> approach.

setuid binaries can still use /etc/ld.preload or whatever the file is called
just not environment.

Someone actually did a libmmx long ago that used preload, hooked SIGILL
and the signal handlers and used that to provide mmx on an mmx free cpu

