Return-Path: <linux-kernel-owner+w=401wt.eu-S964880AbWLMMIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWLMMIF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWLMMIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:08:05 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:39621 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964880AbWLMMIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:08:04 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:08:04 EST
Date: Wed, 13 Dec 2006 12:37:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pete Zaitcev <zaitcev@redhat.com>
cc: jbaron@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Weird code in scripts/kconfig/Makefile
In-Reply-To: <20061212180924.c998f9a8.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.64.0612131235530.1867@scrub.home>
References: <20061212180924.c998f9a8.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Pete Zaitcev wrote:

> In 2.6.19 (and Linus' curent tree), I found the following:
> 
>           libpath=$$dir/lib; lib=qt; osdir=""; \
>           $(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
>             osdir=x$$($(HOSTCXX) -print-multi-os-directory); \
>           test -d $$libpath/$$osdir && libpath=$$libpath/$$osdir; \
> 
> What does the little 'x' do in front of $$(foo)? It looks suspiciously
> like a typo to me.

Indeed, it looks like it. It's the fallback path nowadays, so I guess it 
wasn't noticed so far.

bye, Roman
