Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUIGSIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUIGSIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268233AbUIGSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:07:03 -0400
Received: from verein.lst.de ([213.95.11.210]:59037 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268247AbUIGSGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:06:21 -0400
Date: Tue, 7 Sep 2004 20:06:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] unexport do_execve/do_select
Message-ID: <20040907180616.GB12434@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040907150028.GA9235@lst.de> <1094576549.9599.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094576549.9599.2.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:02:30PM +0100, Alan Cox wrote:
> On Maw, 2004-09-07 at 16:00, Christoph Hellwig wrote:
> > These are basically shared code for native/32bit compat code, but as
> > CONFIG_COMPAT is a bool there's no need to export them.
> 
> do_select at least used to be used by the xABI compatibility modules, is
> that no longer the case ?

For Sparc, the only inkernel one that can be modular - no.  For the x86
ABI modules half of the syscalls needs to be exported so the patch is
huge anyway.
