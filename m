Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVDFUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVDFUQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 16:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVDFUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 16:16:06 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:63750 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262293AbVDFUPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 16:15:37 -0400
Date: Wed, 6 Apr 2005 22:15:33 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050406201533.GB77499@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br> <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet> <4252E6C1.5010701@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4252E6C1.5010701@pobox.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 03:28:01PM -0400, Jeff Garzik wrote:
> * Most firmwares are a -collection- of images and data.  The firmware 
> infrastructure should load an -archive- of firmwares and associated data 
> values.

Why don't you use multiple firmware loading calls with different
names?  Maybe adding a "group" name, or simply adding a '/' in the
name.  That way the userspace half will have the choice between using
directories, tar, zip or whatever.  The speedtouch driver already
requests multiple files, having them together in one file is a
userspace problem which the kernel can help but shouldn't try to solve.

> 
> * The firmware distribution infrastructure is basically non-existent. 
> There is no standard way to make sure that a firmware separated from the 
> driver gets to all users.

That's the price how having non-gpl compatible firmware though.


> * The firmware bundling infrastructure is basically non-existent. 
> (Arjan talked about this)  There needs to be a a way to ensure that the 
> needed firmwares are automatically added to initramfs/initrd.

Yes.  See following too.


> * There is no chicken-and-egg problem as Arjan mentions.  Once the above 
> technical problems are resolved, its trivial to apply a firmware loading 
> patch.  I believe in hard transitions, not shipping tg3 with firmware 
> -and- a firmware loading patch.

An infrastructure to add a number of files to the kernel image (_not_
the initrd/initramfs) which can be found through internal kernel
calls, firmware loading and probably an export in /proc would be nice.
Unifying DSDT override, config.gz and early firmware could be nice.


> * Firmwares such as tg3 should be shipped with the kernel tarball.

Does it change between kernel versions?  How often?

  OG.
