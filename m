Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUIJV1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUIJV1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIJV1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:27:39 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:14527 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267901AbUIJV1R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:27:17 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, David Eger <eger@havoc.gtf.org>,
       adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Sat, 11 Sep 2004 05:27:05 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1094783022.2667.106.camel@gaston> <200409101328.57431.adaplas@hotpop.com> <20040910175202.GA11054@havoc.gtf.org>
In-Reply-To: <20040910175202.GA11054@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409110527.05516.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 01:52, David Eger wrote:
> On Fri, Sep 10, 2004 at 01:28:57PM +0800, Antonino A. Daplas wrote:
> > On Friday 10 September 2004 10:23, Benjamin Herrenschmidt wrote:
> > > Recent changes upstream are breaking fbdev on pmacs.
> > >
> > > I haven't had time to go deep into that (but I suspect Linus sees it
> > > too on his own g5 unless he removed offb from his .config).
> > >
> > > From what I see, it seems that offb is kicking in by default, reserves
> > > the mmio regions, and then whatever chip driver loads can't access
> > > them.
> > >
> > > offb is supposed to be a "fallback" driver in case no fbdev is taking
> > > over, it should also be "forced" in with video=ofonly kernel command
> > > line. This logic has been broken.
>
> I dearly *hope* this is what I'm seeing with recent kernels, though I
> have my doubts....  What I *do* know is that with recent bk snapshots
> (post bk-1.2115) I have the following:  radeonfb seems to load, but when I
> try to load X, my y-resolution seems to be half of what it ought to be...

X-fbdev, or X + native radeon driver?  Do still get a framebuffer console?
Any other fb apps you have that's also broken?

Not sure why that happens. Note that the fbdev changes in the latest bk are
mostly driver specific changes and the initialization code cleanup which I'm
addressing at the moment.

Tony


