Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDDRXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDDRXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDDRXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:23:49 -0400
Received: from mail.gondor.com ([212.117.64.182]:13 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S1750731AbWDDRXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:23:48 -0400
Date: Tue, 4 Apr 2006 19:23:47 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Alsa-devel] Slab corruptions & Re: 2.6.17-rc1: Oops in sound applications
Message-ID: <20060404172347.GA5968@knautsch.gondor.com>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain> <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlkul72rv.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 05:56:36PM +0200, Takashi Iwai wrote:
> At Tue, 4 Apr 2006 15:38:14 +0200,
> Jan Niehusmann wrote:
> > 
> > On Mon, Apr 03, 2006 at 10:01:08PM +0100, Ken Moffat wrote:
> > > 1. One line summary:
> > > 
> > >  On x86, sound applications oops when I refresh the browser.
> > 
> > I also see Oopses which seem to be sound related, although I did
> > not notice a correllation with the browser. The oopses below are from
> > 2.6.17-rc1 with additional ipw2200 patches (first one), and from a clean
> > 2.6.17 (second one). The -dirty suffix in the version numbers comes from
> > compiling with make-kpkg, not from actual changes to the source.
> 
> Could you try the patch below by OGAWA Hirofumi
> <hirofumi@mail.parknet.co.jp>?

That could be it - I remember having problems to access /dev/dsp prior
to the oops, and (without having read the code) it looks like the patch
is related to some error condition on open(). I'll try the patch.

Jan
