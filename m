Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbTEKR41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTEKR41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:56:27 -0400
Received: from palrel11.hp.com ([156.153.255.246]:59092 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261824AbTEKR4Z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:56:25 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16062.37308.611438.5934@napali.hpl.hp.com>
Date: Sun, 11 May 2003 11:09:00 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, davej@suse.de, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <1052653415.12338.159.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 11 May 2003 13:43:36 +0200, Michel Dänzer <michel@daenzer.net> said:

  Michel> On Sam, 2003-05-10 at 12:09, David Mosberger wrote:
  >>  This patch is rather big, but actually very straight-forward: it
  >> adds a "agp dev" argument to DRM_IOREMAP(),
  >> DRM_IOREMAP_NOCACHE(), and DRM_IOREMAPFREE() and then uses it in
  >> drm_memory.h to support platforms where CPU accesses to the AGP
  >> space are not translated by the GART (true for ia64 and alpha,
  >> not true for x86, I don't know about the other platforms).  On
  >> platforms where cant_use_aperture is always false, this whole
  >> patch will look like a no-op.  On ia64, it works.  Don't know
  >> about other platforms, but it should simplify things for Alpha at
  >> least (and if it breaks a platform, I shall be happy to work with
  >> the respective maintainer to get fix back to working).

  Michel> I'd love to commit this to DRI CVS,

Great!

  Michel> but there'd have to be fallbacks for older kernels (this is
  Michel> against 2.4.20-ben8):

OK, we have a chicken & egg problem then: I could obviously add Linux
kernel version checks where needed, but to do that, the patch first
needs to go into the kernel.  Dave, would you mind applying the patch
to your tree?  Then once Linus picked it up, I can send a new patch to
dri-devel.  Or does someone have a better suggestion?

	--david
