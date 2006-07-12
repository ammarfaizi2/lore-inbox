Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWGLNiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWGLNiE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWGLNiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:38:04 -0400
Received: from ns2.suse.de ([195.135.220.15]:39588 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751365AbWGLNiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:38:01 -0400
From: Andi Kleen <ak@suse.de>
To: Kevin Brown <kevin@sysexperts.com>
Subject: Re: skge error; hangs w/ hardware memory hole
Date: Wed, 12 Jul 2006 15:37:53 +0200
User-Agent: KMail/1.9.1
Cc: Anthony DeRobertis <asd@suespammers.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Martin Michlmayr <tbm@cyrius.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060703205238.GA10851@deprecation.cyrius.com> <121226.1152672894714.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <44B475F9.2010805@sysexperts.com>
In-Reply-To: <44B475F9.2010805@sysexperts.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121537.53586.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 06:09, Kevin Brown wrote:
> Andreas Kleen wrote:
> > If it helps I can do a proper patch that only bounces IO > 4GB through
> > the copy.
>
> For the A8V series of boards, that will almost certainly be just fine,
> because as far as I know you can't populate them with more than 4G of
> memory anyway.

Even if you only put 4GB in then memory remapping for the PCI hole will 
usually put some memory beyond 4GB.

Of course again the mainboard vendor seems to have never
tested this so there might be other more subtle problems the kernel can't
help with.

>
> If someone has more than 4G of memory, it's likely they'll be willing to
> take the performance hit from the mod in exchange for being able to use
> more than 4G of memory.

Somewhat of a platitude. They would have no choice.

>
> Bottom line: do the patch.  It'll be worth using.

I'm still waiting for a positive test result. Ideally from multiple people 
because it's a pretty radical step to blacklist all VIA chipsets like this
(and it's s still possible that only some BIOS are broken, not all VIA boards)
In fact I've been trying to get confirmation from VIA on this, but they
never answered my queries.

-Andi
