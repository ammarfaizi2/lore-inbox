Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUIUTGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUIUTGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUIUTGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:06:09 -0400
Received: from cantor.suse.de ([195.135.220.2]:1227 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267977AbUIUTGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:06:07 -0400
Date: Tue, 21 Sep 2004 21:06:06 +0200
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alex Williamson <alex.williamson@hp.com>,
       acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921190606.GE18938@wotan.suse.de>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi> <20040921172625.GA30425@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921172625.GA30425@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 07:26:25PM +0200, Pavel Machek wrote:
> > +struct special_cmd {
> > +        u32                     magic;
> > +        unsigned int            cmd;
> > +        char                    *args;
> > +};
> 
> Talk to Andi Kleen; passing such structures using read/write is evil,
> because (unlike ioctl) there's no place to put 32/64bit
> translation. Imagine i386 application running on x86-64 system.

Yes, Pavel is right. Please don't pass pointers by read/write
because it cannot be 32bit emulated.

-Andi
