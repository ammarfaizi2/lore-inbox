Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWDFA5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWDFA5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 20:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWDFA5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 20:57:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:19349 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750777AbWDFA53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 20:57:29 -0400
Date: Wed, 5 Apr 2006 17:55:46 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: gregkh@suse.de, torvalds@osdl.org, tytso@mit.edu, zwane@arm.linux.org.uk,
       jmforbes@linuxtx.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net, eugene.teo@eugeneteo.net, davej@redhat.com,
       chuckw@quantumlinux.com, stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [patch 02/26] USB: Fix irda-usb use after use
Message-ID: <20060406005546.GA18532@kroah.com>
References: <20060404235634.696852000@quad.kroah.org> <20060404235927.GA27049@kroah.com> <20060404235943.GC27049@kroah.com> <20060404.171644.12655459.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404.171644.12655459.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 05:16:44PM -0700, David S. Miller wrote:
> From: gregkh@suse.de
> Date: Tue, 4 Apr 2006 16:59:43 -0700
> 
> > Don't read from free'd memory after calling netif_rx().  docopy is used as
> > a boolean (0 and 1) so unsigned int is sufficient.
> > 
> > Coverity bug #928
> > 
> > Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
> > Cc: "David Miller" <davem@davemloft.net>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks, I've added this to the patch.

greg k-h
