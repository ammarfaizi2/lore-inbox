Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTELUGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbTELUGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:06:36 -0400
Received: from palrel12.hp.com ([156.153.255.237]:61648 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262584AbTELUGe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:06:34 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16064.453.497373.127754@napali.hpl.hp.com>
Date: Mon, 12 May 2003 13:19:17 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [Dri-devel] Re: Improved DRM support for cant_use_aperture
	platforms
In-Reply-To: <1052768911.10752.268.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 12 May 2003 21:48:31 +0200, Michel Dänzer <michel@daenzer.net> said:

  >> using an old kernel that doesn't have asm/agp.h yet?).

  Michel> That's it.

OK, thanks for clarifying.

  Michel> So we have to check the version before #including
  Michel> <asm/agp.h>. Then, we can do something like

  Michel> #ifndef PAGE_AGP #define PAGE_AGP PAGE_KERNEL_NOCACHE #endif

  Michel> Or am I missing something?

Basically correct, except that the patch also needs an improved
version of vmap(), which was introduced in 2.5.68 only (IIRC).  I'll
update my patch so it is a no-op unless you have a kernel >= 2.5.68.

	--david
