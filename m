Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUFOSs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUFOSs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265859AbUFOSs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:48:59 -0400
Received: from ppp13-ax.noc.teithe.gr ([195.251.120.13]:18051 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S265841AbUFOSs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:48:58 -0400
From: V13 <v13@priest.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kbuild: make clean improved
Date: Tue, 15 Jun 2004 21:50:37 +0300
User-Agent: KMail/1.6.52
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204655.GE15243@mars.ravnborg.org> <20040614215034.K14403@flint.arm.linux.org.uk>
In-Reply-To: <20040614215034.K14403@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406152150.37716.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 June 2004 23:50, Russell King wrote:
> On Mon, Jun 14, 2004 at 10:46:55PM +0200, Sam Ravnborg wrote:
> >  # Directories & files removed with 'make clean'
> >  CLEAN_DIRS  += $(MODVERDIR)
> > -CLEAN_FILES +=	vmlinux System.map \
> > +CLEAN_FILES +=	vmlinux System.map .version .config.old \
> >                  .tmp_kallsyms* .tmp_version .tmp_vmlinux*
>
> Why should 'make clean' remove the build version?  Traditionally,
> this has been preserved until 'make mrproper'.

I believe that when removing .version you should remove .config too, so either 
it should include .config or it should not include .version.

<<V13>>
