Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266586AbUFVFV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266586AbUFVFV6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 01:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266589AbUFVFV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 01:21:58 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:61269 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266586AbUFVFV5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 01:21:57 -0400
Date: Tue, 22 Jun 2004 07:33:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm1
Message-ID: <20040622053349.GA2738@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <20040620174632.74e08e09.akpm@osdl.org> <20040621020420.GL27822@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621020420.GL27822@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 04:04:20AM +0200, Adrian Bunk wrote:
> On Sun, Jun 20, 2004 at 05:46:32PM -0700, Andrew Morton wrote:
> >...
> > +wanxl-firmware-build-fix.patch
> > 
> >  Fix allmodconfig build
> >...
> 
> This option is in drivers/base/Kconfig, but the similar option 
> STANDALONE [1] is in init/Kconfig.
> 
> Shouldn't buoth be at the same place?
> What about moving STANDALONE ad let it depend on PREVENT_FIRMWARE_BUILD?

STANDALONE avoids any drivers not using external firmware.
PREVENT_FIRMWARE_BUILD just prevents the supplied firmware to be build.
So no I do not see they should be dependent.

But for sure they should be located in the same place.
This is drivers only information and not related to the actual
maturity of the code - so moving STANDALONE to drivers/base
makes sense to me.
Adrian - care to submit a patch?

	Sam
