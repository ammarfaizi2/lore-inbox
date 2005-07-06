Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVGFXga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVGFXga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVGFXec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 19:34:32 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:33579 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262552AbVGFXd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 19:33:56 -0400
X-IronPort-AV: i="3.94,174,1118034000"; 
   d="scan'208"; a="262726751:sNHT18638880"
Date: Wed, 6 Jul 2005 18:41:19 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050706234119.GA5949@sysman-doug.us.dell.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706041702.GA10253@kroah.com> <20050706155734.GA4271@sysman-doug.us.dell.com> <20050706160737.GC13115@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706160737.GC13115@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 09:07:37AM -0700, Greg KH wrote:
> On Wed, Jul 06, 2005 at 10:57:35AM -0500, Doug Warzecha wrote:
> > On Tue, Jul 05, 2005 at 11:17:03PM -0500, Greg KH wrote:
> > >    > +static void dcdbas_device_release(struct device *dev)
> > >    > +{
> > >    > +     /* nothing to release */
> > >    > +}
> > > 
> > >    This is a symptom of a broken driver.
> > > 
> > >    Hm, I wonder if there's some way for the compiler to check the fact that
> > >    a function pointer passed to another function, is really a null
> > >    function.  That would stop this kind of nonsense...
> > 
> > There are other drivers in the kernel tree with null device release functions.
> 
> Where?

Here's a couple:

drivers/video/vfb.c: vfb_platform_release
drivers/video/epson1355fb.c: epson1355fb_platform_release

Doug
