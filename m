Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWHYKkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWHYKkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWHYKkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:40:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45962 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932418AbWHYKkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:40:46 -0400
Subject: Re: [PATCH 2/4] Core support for --combine -fwhole-program
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060825103029.GV19810@stusta.de>
References: <1156429585.3012.58.camel@pmac.infradead.org>
	 <1156433167.3012.119.camel@pmac.infradead.org>
	 <20060824213302.GS19810@stusta.de>
	 <1156498643.2984.28.camel@pmac.infradead.org>
	 <20060825103029.GV19810@stusta.de>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 11:40:44 +0100
Message-Id: <1156502444.2984.89.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-25 at 12:30 +0200, Adrian Bunk wrote:
> My hope is "insane" would be something like "1 GB of RAM" that is no 
> longer insane on current computers. [1]

Maybe -- but still, that's quite a steep requirement, and would also
require a fairly major redesign of the current kbuild architecture. 

I'm inclined to stick with per-directory builds for now, which is both
relatively simple to implement and where the _majority_ of the benefit
it likely to be seen.

Whole-kernel optimisation is something I'm inclined to leave until LTO
happens -- but don't let me stop you from investigating it.

> > I suspected that most of the 'further savings' to which you refer above
> > could be achieved more easily with -ffunction-sections -fdata-sections
> > --gc-sections
> 
> AFAIR -ffunction-sections/-fdata-sections cause some overhead in the 
> resulting binary?

Not that I'm aware of. There's overhead in the resulting ELF files, but
we combine sections in the vmlinux.lds so there isn't even that overhead
in the vmlinux. 

-- 
dwmw2

