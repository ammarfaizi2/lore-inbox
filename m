Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTKXP2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263767AbTKXP2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:28:41 -0500
Received: from ns2.uk.superh.com ([193.128.105.170]:61605 "EHLO
	smtp.uk.superh.com") by vger.kernel.org with ESMTP id S263764AbTKXP2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:28:40 -0500
Date: Mon, 24 Nov 2003 15:28:19 +0000
From: Richard Curnow <Richard.Curnow@superh.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: Simplification in pbus_size_mem
Message-ID: <20031124152819.GB5895@malvern.uk.w2k.superh.com>
Mail-Followup-To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Greg KH <greg@kroah.com>
References: <20031120122838.GA4575@malvern.uk.w2k.superh.com> <20031120171624.A30024@jurassic.park.msu.ru> <20031120152558.GA5895@malvern.uk.w2k.superh.com> <20031120193606.A30216@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031120193606.A30216@jurassic.park.msu.ru>
X-OS: Linux 2.4.22 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 24 Nov 2003 15:29:27.0982 (UTC) FILETIME=[BF8E3CE0:01C3B29F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivan Kokshaysky <ink@jurassic.park.msu.ru> [2003-11-20]:
> On Thu, Nov 20, 2003 at 03:25:58PM +0000, Richard Curnow wrote:
> > So is the idea that by rounding up 'size' to 96Mb in this case, it's
> > guaranteed that there will be a 64Mb aligned chunk inside where the
> > framebuffer can go, still leaving enough room around for the other
> > allocation, _regardless_ of the alignment of the base of the memory
> > aperture?  (Or if there are multiple PCI-to-PCI bridges, the aperture
> > base for any one bridge is going to depend on the sizes of the apertures
> > forwarded by the others, I suppose).
> 
> Exactly.

OK, so it's a tricky general-case problem then.  After a day or two
pondering, I doubt there's much that can be improved without sinking a
_lot_ of time into this.

> > How do I do that?
> 
> Add a 'pcibios_fixup' routine for this platform, which does

Thanks for this info!  It's useful to have at least another solution to
consider instead of the bodge we're already using.

> It can be either specific for that VGA controller (if it's built-in)

no, it's not built in.

Thanks again
Richard

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
