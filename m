Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVDFW0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVDFW0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 18:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbVDFW0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 18:26:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:23223 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262338AbVDFW0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 18:26:52 -0400
Date: Wed, 6 Apr 2005 15:23:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ben Castricum <benc@bencastricum.nl>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 compile error in drivers/usb/class/cdc-acm.c
Message-Id: <20050406152342.4d670f51.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504061012420.31870@gateway.bencastricum.nl>
References: <Pine.LNX.4.58.0504051026330.30674@gateway.bencastricum.nl>
	<20050406001807.GB7226@stusta.de>
	<Pine.LNX.4.58.0504061012420.31870@gateway.bencastricum.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Castricum <benc@bencastricum.nl> wrote:
>
> 
> 
> On Wed, 6 Apr 2005, Adrian Bunk wrote:
> 
> > On Tue, Apr 05, 2005 at 10:54:09AM +0200, Ben Castricum wrote:
> > > ...
> > >   CC      fs/quota_v2.o
> > > fs/quota_v2.c: In function `v2_write_dquot':
> > > fs/quota_v2.c:399: warning: unknown conversion type character `z' in
> > > format
> > > fs/quota_v2.c:399: warning: too many arguments for format
> >
> > These are warnings that only occur with gcc 2.95 and that can safely be
> > ignored.
> 
> Just wondering, isn't 2.95.3 the recommended compiler anymore? I only use
> this (a bit old) version because it's _the_ compiler for the kernel.
> 
> If it still is then I find it a bit strange that code is accepted that
> doesn't compile cleanly on the recommended compiler.
> 

gcc-2.95.x requires %Z, not %z.  The latter is more correct, and not many
people use gcc-2.95.x, so we'll just have to live with the warnings, I'm
afraid.

I patched my gcc-2.95.4 to understand %z, but seem to have not put the
patch anywhere where I can find it.

