Return-Path: <linux-kernel-owner+w=401wt.eu-S1750752AbWLMCs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWLMCs6 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWLMCs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:48:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35205 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbWLMCs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:48:57 -0500
X-Greylist: delayed 1124 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 21:48:57 EST
Date: Tue, 12 Dec 2006 21:28:51 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Pete Zaitcev <zaitcev@redhat.com>
cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: Weird code in scripts/kconfig/Makefile
In-Reply-To: <20061212180924.c998f9a8.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.64.0612122112220.11690@dhcp83-20.boston.redhat.com>
References: <20061212180924.c998f9a8.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Dec 2006, Pete Zaitcev wrote:

> Hi, Roman & All:
> 
> In 2.6.19 (and Linus' curent tree), I found the following:
> 
>           libpath=$$dir/lib; lib=qt; osdir=""; \
>           $(HOSTCXX) -print-multi-os-directory > /dev/null 2>&1 && \
>             osdir=x$$($(HOSTCXX) -print-multi-os-directory); \
>           test -d $$libpath/$$osdir && libpath=$$libpath/$$osdir; \
> 
> What does the little 'x' do in front of $$(foo)? It looks suspiciously
> like a typo to me.
> 
> I think Jason caught it, but I didn't see a correction sent out.
> 

yes. looks like an error to me too...i left it out of an internal patch to 
this code. Since we are testing for the existence of the directory, it has 
probably gone unnoticed.
