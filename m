Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTIPUzq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 16:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTIPUzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 16:55:46 -0400
Received: from havoc.gtf.org ([63.247.75.124]:60098 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262491AbTIPUzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 16:55:45 -0400
Date: Tue, 16 Sep 2003 16:55:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add likely around access_ok for uaccess
Message-ID: <20030916205545.GA14153@gtf.org>
References: <3F644E36.5010402@colorfullife.com> <20030916194929.GF602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916194929.GF602@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 09:49:29PM +0200, Pavel Machek wrote:
> Hi!
> 
> > while trying to figure out why sysv msg is around 30% slower than pipes 
> > for data transfers I noticed that gcc's autodetection (3.2.2) guesses 
> > the "if(access_ok())" tests in uaccess.h wrong and puts the error memset 
> > into the direct path and the copy out of line.
> > 
> > The attached patch adds likely to the tests - any objections? What about 
> > the archs except i386?
> 
> How much speedup did you gain?

How much can it hurt?

	Jeff



