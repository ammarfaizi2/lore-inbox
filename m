Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbUJWOmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbUJWOmw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUJWOmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:42:52 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:48395 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261260AbUJWOjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:39:18 -0400
Date: Sat, 23 Oct 2004 15:39:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH} Trivial - fix drm_agp symbol export
Message-ID: <20041023143912.GA32532@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>
References: <9e473391041022214570eab48a@mail.gmail.com> <20041023095644.GC30137@infradead.org> <9e473391041023073578b11eb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391041023073578b11eb6@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:35:41AM -0400, Jon Smirl wrote:
> How do I deal with something like a Redhat kernel where CONFIG_AGP is
> set but the kernel may be running on hardware without AGP present. In
> this case the AGP modules will not be loaded but DRM will still have
> symbol references to the AGP symbols. You have to have some kind of
> weak symbol reference in this case.

agpgart.o will load without any hardware present in 2.6, and you don't
need the lowlevel drivers.  2.4 was slightly messed up in this regard.
