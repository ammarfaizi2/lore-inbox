Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUHDFBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUHDFBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266787AbUHDFBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:01:55 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15794 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266845AbUHDFBx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:01:53 -0400
Date: Wed, 4 Aug 2004 07:01:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Zinx Verituse <zinx@epicsol.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Message-ID: <20040804050144.GB8139@suse.de>
References: <20040730193651.GA25616@bliss> <20040731153609.GG23697@suse.de> <20040731182741.GA21845@bliss> <20040731200036.GM23697@suse.de> <1091490870.1649.23.camel@localhost.localdomain> <20040803055337.GA23504@suse.de> <20040803161747.GA16293@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803161747.GA16293@bliss>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03 2004, Zinx Verituse wrote:
> > > We'd end up with a list of allowed commands for all sorts of operations
> > > that don't threaten the machine while blocking vendor specific wonders
> > > and also cases where users can do stuff like firmware erase.
> > 
> > Sorry, I think this model is totally bogus and I'd absolutely refuse to
> > merge any such beast into the block layer sg code.
> > 
> 
> Well, would something like this patch be acceptable?  It just makes
> SG_IO require write access to the device (cdrecord and cdrdao both
> open it this way already, so users shouldn't have a problem with it).
> I probably forgot some stuff, etc.  I'm not terribly familiar with the
> code in question.

Absolutely not. I've already outlined why in my previous mails I don't
want to see anything like this, and this patch is even worse than
filtering. Additionally, you risk breaking existing programs.

-- 
Jens Axboe

