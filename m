Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWHYKel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWHYKel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHYKel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:34:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:15840 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932441AbWHYKek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:34:40 -0400
Subject: Re: [PATCH 3/4] Add __global tag where needed.
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060825102649.GU19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433212.3012.120.camel@pmac.infradead.org>
	 <20060824213047.GR19810@stusta.de>
	 <1156499546.2984.43.camel@pmac.infradead.org>
	 <20060825102649.GU19810@stusta.de>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 11:34:38 +0100
Message-Id: <1156502078.2984.81.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 12:26 +0200, Adrian Bunk wrote:
> On Fri, Aug 25, 2006 at 10:52:26AM +0100, David Woodhouse wrote:
> > On Thu, 2006-08-24 at 23:30 +0200, Adrian Bunk wrote:
> > > Applying this doesn't seem to make much sense until it's clear whether a
> > > "build everything except for assembler files at once" approach (that 
> > > needs less globals) or your current "compile only multi-obj at once" 
> > > approach (that requires more globals). 
> > 
> > For the kernel itself, I think that building a directory at once is the
> > way forward. For modules, obviously the scope is more limited.
> 
> For any desktop or server you buy today your patches are a nice 
> improvement but not that important.

Yes, I agree -- although I haven't tested for performance yet; there
_may_ be something surprisingly improved in there but I suspect it's
unlikely.

> But projects like embedded systems or OLPC that really need want 
> kernels should be the same projects that already avoid the
> 10% size penalty of CONFIG_MODULES=y.

OLPC has USB ports and wants to be fairly flexible about being able to
connect stuff -- I don't think we can turn off CONFIG_MODULES in its
running kernel. However, its _boot_ kernel (LinuxBIOS) has
CONFIG_MODULES=n, and that's where we _really_ care about the space.

-- 
dwmw2

