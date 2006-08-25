Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWHYKPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWHYKPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWHYKPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:15:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7644 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750827AbWHYKPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:15:14 -0400
Subject: Re: [PATCH 0/4] Compile kernel with -fwhole-program --combine
From: David Woodhouse <dwmw2@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060825072654.GC30453@uranus.ravnborg.org>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433068.3012.115.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608241840440.16422@yvahk01.tjqt.qr>
	 <1156439110.3012.147.camel@pmac.infradead.org>
	 <Pine.LNX.4.61.0608250759190.7912@yvahk01.tjqt.qr>
	 <20060825072654.GC30453@uranus.ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Aug 2006 11:14:53 +0100
Message-Id: <1156500893.2984.70.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 09:26 +0200, Sam Ravnborg wrote:
> And this discussion is btw. mood. If the general opinion is that we shall
> include the -combine support all the kbuild infrastructure will anyway
> be redone.
> There are several small things that are not addressed in todays
> implementation and that will be fixed one way or the other.

There's a few _big_ things that aren't addressed in my makefile hack
either. It's very much a proof of concept.

However, if we limit the use of --combine to files within the same
directory, the modifications to the kbuild infrastructure shouldn't be
too intrusive. I strongly suspect that files within the same directory
are where the majority of the benefit is anyway.

Whole-kernel optimisation is likely to be prohibitively expensive, and
can wait for LTO¹.

-- 
dwmw2
¹ http://www.gelato.org/pdf/apr2006/gelato_ICE06apr_lto_mitchell_codesourcery.pdf

