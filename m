Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265840AbUGZUIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbUGZUIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUGZUIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:08:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52959 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266049AbUGZTUJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:20:09 -0400
Date: Sat, 24 Jul 2004 14:17:06 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Peter Santoro <psantoro@att.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.26 oops (maybe solved)
Message-ID: <20040724171706.GA2530@dmt.cyclades>
References: <40FF33DE.6010307@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FF33DE.6010307@att.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 11:26:22PM -0400, Peter Santoro wrote:
> After trying many h/w and s/w configurations, I've apparently isolated 
> my instability issues to using the following the linux kernel highmem 
> options: CONFIG_HIGHMEM4G=y, CONFIG_HIGHMEM=y, CONFIG_HIGHMEMIO=y.  I 
> have 1GB ram, so maybe one of my dimms is bad or maybe there's a highmem 
> bug in the 2.4.X kernel.
> 
> The crashes in my previous emails today were due to using the latest 
> alsa modules (loaded, but not used by any application) with a HIGHMEM 
> enabled kernel.  I appear to have no problem using alsa when HIGHMEM is 
> disabled.  Apparently, I'm not the only one having problems with alsa 
> and highmem 
> (http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg13918.html).
> 
> I would be willing to work with a kernel developer to better isolate 
> this problem and test a patch.

Hi Peter, 

Care to disable ALSA to see if the problem really only happens
when running ALSA+HIGHMEM ?

Your previous oopses in core VM code seem to be hardware problems
to me, I haven't done any deep analysis though.
