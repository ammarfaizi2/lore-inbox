Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264326AbUACWZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264333AbUACWZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:25:06 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:46760 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264326AbUACWZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:25:02 -0500
Date: Sat, 3 Jan 2004 14:24:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alex Buell <alex.buell@munted.org.uk>
Cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode_cache / dentry_cache not being reclaimed aggressively enough  on low-memory PCs
Message-ID: <20040103222454.GJ1882@matchmail.com>
Mail-Followup-To: Alex Buell <alex.buell@munted.org.uk>,
	Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0401031128100.2605@slut.local.munted.org.uk> <20040103103023.77bf91b5.jlash@speakeasy.net> <Pine.LNX.4.58.0401031823010.3488@slut.local.munted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401031823010.3488@slut.local.munted.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 06:27:42PM +0000, Alex Buell wrote:
> On Sat, 3 Jan 2004, John Lash wrote:
> > A couple of solutions come to mind. The one I like best would be to
> > adjust the above code to make it conscious of the total memory in the
> > system and keep nr_unused to a reasonable percentage. Another is to
> > allow unused_ratio to be less than 1, Possibly some/proc entry to lower
> > it (.5, .25, whatever), or to avoid the float, provide another parameter
> > to do an integer divisor for unused_ratio. Something like:
> > 
> > 	nr_unused - nr_used * unused_ratio / ratio_fraction
> 
> That solution does seem be the best answer.

Be sure to run your changes by roger luetger.  He's working with the
problems with lowmem machines and 2.6.
