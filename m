Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUDCB73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUDCB73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:59:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:28054 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261416AbUDCB72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:59:28 -0500
Date: Sat, 3 Apr 2004 02:59:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: andersen@codepoet.org, Pavel Machek <pavel@ucw.cz>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403015920.GA2857@mail.shareable.org>
References: <s5g7jx31int.fsf@patl=users.sf.net> <20040329231635.GA374@elf.ucw.cz> <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <20040403012112.GA6499@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403012112.GA6499@codepoet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> > Here's a tricky situation:
> > 
> >    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> > 
> >    2. At this point both mappings share the same pages in RAM.
> > 
> >    3. Then one of the cowlinks is written to...
> 
> Using mmap with PROT_WRITE on a cowlink must preemptively
> break the link.

I forget to mention, they are PROT_READ shared mappings.

-- Jamie
