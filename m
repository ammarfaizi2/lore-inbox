Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVBPIf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVBPIf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 03:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVBPIf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 03:35:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38366 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261958AbVBPIfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 03:35:51 -0500
Date: Wed, 16 Feb 2005 08:35:50 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: Fix sparse warnings
Message-ID: <20050216083550.GO8859@parcelfarce.linux.theplanet.co.uk>
References: <200502151455.55711.adobriyan@mail.ru> <20050215115934.GK8859@parcelfarce.linux.theplanet.co.uk> <200502151512.37774.adobriyan@mail.ru> <20050215192618.GL8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215192618.GL8859@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 07:26:18PM +0000, Al Viro wrote:
> Umm...  Let's do it that way: I'll get carving the sucker up to relatively
> sane point and post it again (-bird, that is).  Give me until tomorrow
> morning and then feel free to send stuff my way - I'll merge it and feed
> upstream when 2.6.11 opens (credited, obviously).

Gaack...  My apologies - I've seriously underestimated the amount of RL
crap, so no, it won't be ready today.  I'll try to do that ASAP, but I can't
make a good estimate of how much I'll be able to do during the next week.
Crap...

OK, let's do it that way - send the stuff my way, I'll port it if needed
and if there are duplicates, your patches win.  FWIW, stuff in fs/* is
	* a bunch of patches in fs/reiserfs/* (carved up, see R[0-4]-* on
ftp.linux.org.uk/pub/people/viro)
	* nfs, nfsd, lockd and net/sunrpc along with them (not carved up
into sane form and that will be needed to even start talking about merge)
	* compat_ioctl.c (part of i2c annotations)
	* fs/hostfs/* (part of UML patches, so that'll a part of further split
once the things stabilize a bit)
	* couple of trivial ones - procfs (duplicate of your patch) and
ncpfs (ncp_request_reply.sign made be32[6])
	* include-ectomy in a lot of places, but that's not likely to clash
with your stuff.

Most of the mess is in drivers/*, arch/* and (for endianness patches) net/*...
