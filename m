Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWGLMve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWGLMve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWGLMve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:51:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48806 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751363AbWGLMve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:51:34 -0400
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
From: Arjan van de Ven <arjan@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Sam Ravnborg <sam@ravnborg.org>, Petr Vandrovec <petr@vandrovec.name>,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <44B4D666.706@vc.cvut.cz>
References: <1152631729.3373.197.camel@pmac.infradead.org>
	 <44B435DE.4040708@vandrovec.name>
	 <20060712033722.GA13096@mars.ravnborg.org>  <44B4D666.706@vc.cvut.cz>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 14:51:29 +0200
Message-Id: <1152708689.3217.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-12 at 13:00 +0200, Petr Vandrovec wrote:
> Sam Ravnborg wrote:
> >>FYI, fortunately (for you, unfortunately for VMware) 2.6.18's already broke 
> >>our build script due to UTS_RELEASE being moved to separate file, so from 
> >>VMware's viewpoint killconfig.h.git will not do any additional damage...
> > 
> > #include <linux/config.h>
> > #ifndef UTS_RELEASE
> > #include <linux/utsrelease.h>
> > #endif
> > 
> > Then one can wonder why WMware needs UTS_RELEASE?
> 
> To make sure user is building modules for kernel it is really using.  Without
> this test users were building modules for kernels they have run years ago, and
> then complained that modules do not fit to running kernel, or that kernel
> crashes when they do 'insmod -f ...'...  So perl wrapper passes linux/version.h
> through C preprocessor and compares resulting UTS_RELEASE with `uname -r`, and
> complains loudly if they do not match.
> 					

isn't this exactly what VERMAGIC is for instead?


