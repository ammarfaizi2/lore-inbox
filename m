Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUENNnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUENNnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265281AbUENNnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:43:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57509 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265282AbUENNn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:43:28 -0400
Date: Fri, 14 May 2004 14:43:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cramfs as initrd still fails in 2.4.27-pre2 [PATCH]
Message-ID: <20040514134326.GK17014@parcelfarce.linux.theplanet.co.uk>
References: <20040514132955.GA6190@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040514132955.GA6190@man.manty.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:29:55PM +0200, Santiago Garcia Mantinan wrote:
> In Debian official kernel packages cramfs is being used as the initrd, so I
> had a look at Debian's kernel patches and extracted this one that makes
> initrd work for me in 2.4.26 and 2.4.27-pre2:

Patch in debian kernel package is a mindless crap.  cramfs has no business
messing with block size (or buffer cache in general, to start with).  2.6
has it fixed the right way, there's a backport to 2.4 and IIRC it was
scheduled for inclusion.
