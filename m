Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271701AbTGRCYf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271697AbTGRCXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:23:47 -0400
Received: from d40.sstar.com ([209.205.179.40]:29948 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S271694AbTGRCWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:22:12 -0400
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: DRM, radeon, and X 4.3
Date: Thu, 17 Jul 2003 21:36:56 -0500
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200307170539.25702.andy@asjohnson.com> <20030717172625.GA16502@suse.de>
In-Reply-To: <20030717172625.GA16502@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307172136.56019.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 July 2003 12:26 pm, Dave Jones wrote:
> On Thu, Jul 17, 2003 at 05:39:25AM -0500, Andrew S. Johnson wrote:
>  > I start X but it says DRM is disabled, even though the
>  > radeon and agpgart modules are loaded.  Here is the dmesg tail:
>  > 
>  > Linux agpgart interface v0.100 (c) Dave Jones
>  > [drm] Initialized radeon 1.9.0 20020828 on minor 0
>  > [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
>  > [drm:radeon_unlock] *ERROR* Process 1929 using kernel context 0
>  > 
>  > There is something X doesn't like.  How do I fix this?
> 
> Looks like there isn't an agp chipset module also loaded
> (via-agp.o, intel-agp.o etc...)
> 
> You should have additional text after the first AGP line.
> 
> 		Dave

In the 2.4 kernels, the chipset was compiled in with the agpgart
module.  Now they are separate.  So, yes, modprobe via-agp
did the trick.

How can get the modprobe.conf file to load this module after
agpgart and not crash the system?  My attempts to make this
work using the install command example from the manpage
have been generally disasterous.

Thanks,

Andy Johnson


