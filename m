Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTJALDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 07:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbTJALDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 07:03:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261845AbTJALDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 07:03:04 -0400
Date: Wed, 1 Oct 2003 12:03:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6: why no EXPORT_SYMBOL of get_sb_pseudo()?
Message-ID: <20031001110303.GQ7665@parcelfarce.linux.theplanet.co.uk>
References: <16250.39070.555465.86772@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16250.39070.555465.86772@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 11:04:30AM +0200, Mikael Pettersson wrote:
> fs/libfs.c:get_sb_pseudo() isn't exported to modules,
> but a lot of the other stuff in fs/libfs.c is.
> 
> Is there a particular reason for this or just an oversight?
> 
> Making a private copy of get_sb_pseudo()'s definition works
> in a module, but that's not exactly productive use of
> programmer time or source and object code space.

Are you really sure that get_sb_pseudo() is what you need?  It might be
possible, but I suspect that simple_fill_super() would be the right thing
to use.  Care to give details?
