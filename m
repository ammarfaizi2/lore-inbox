Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbTELVi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTELVi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:38:26 -0400
Received: from palrel13.hp.com ([156.153.255.238]:41141 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261962AbTELViY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:38:24 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.5964.342357.501507@napali.hpl.hp.com>
Date: Mon, 12 May 2003 14:51:08 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <1052774487.10750.294.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Michel> Hmm, isn't there a way to make it work with older kernels as
  Michel> well?  For reference, we've been using
  Michel> http://www.penguinppc.org/~daenzer/DRI/drm-ioremapagp.diff
  Michel> by Benjamin Herrenschmidt for a while for Apple UniNorth
  Michel> northbridges.

It should be possible to add vmap() and vunmap() to kernel/vmalloc.c
on older kernels.  I think those are the only dependencies (apart from
PAGE_AGP, which is taken care of by the latest patch).

  Michel> I was hoping to replace it with a cleaner solution like
  Michel> yours.

Is there someone else on this list who would be able to look into
backporting vmap()/vunmap() to 2.4?  I don't use 2.4 with any
regularity anymore, but I suppose if nobody else is interested, I
could look into it.

  Michel> Anyway, after applying your second patch, things looked much
  Michel> better, and the attached patch against the DRI CVS trunk
  Michel> builds without warnings here.

Great!  Does this mean that next time Linus does a pull he'll pick up
this stuff?

	--david
