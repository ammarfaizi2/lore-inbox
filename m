Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWFVE4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWFVE4e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932796AbWFVE4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:56:34 -0400
Received: from thunk.org ([69.25.196.29]:55200 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932228AbWFVE4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:56:33 -0400
Date: Wed, 21 Jun 2006 23:11:27 -0400
From: Theodore Tso <tytso@mit.edu>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 8/8] inode-diet: Fix size of i_blkbits, i_version, and i_dnotify_mask
Message-ID: <20060622031127.GA11224@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20060621125146.508341000@candygram.thunk.org> <20060621125218.183987000@candygram.thunk.org> <200606212335.00176.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606212335.00176.arnd@arndb.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 11:34:59PM +0200, Arnd Bergmann wrote:
> Am Wednesday 21 June 2006 14:51 schrieb Theodore Tso:
> >         umode_t                 i_mode;
> > +       unsigned short          i_blkbits;
> >         unsigned int            i_nlink;
> 
> umode_t is 32 on some platforms, e.g. powerpc64, so you don't get
> optimal packing there.

True, but it's no worse than before.  

						- Ted
