Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUBREgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBREgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:36:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3047 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262888AbUBREf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:35:58 -0500
Date: Wed, 18 Feb 2004 04:35:55 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: module unload deadlock
Message-ID: <20040218043555.GY8858@parcelfarce.linux.theplanet.co.uk>
References: <20040217172646.GT4478@dualathlon.random> <20040218041527.052222C510@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040218041527.052222C510@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 02:29:21PM +1100, Rusty Russell wrote:
> > the actual module doing request_modules in the cleanup handler is
> > parport_pc, calling parport_enumerate (it calls it for another reason,
> > and parport enumerate is told to load up a lowlevel driver if none was
> > present, that's worthless for the unload routine but it's useful for all
> > other calls of parport_enumerate). It's uncertain if other drivers

Bullshit.  Other calls of parport_enumerate() must die - along with that one.
Patches will go to akpm tomorrow.
