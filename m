Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWGLLA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWGLLA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 07:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWGLLA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 07:00:57 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:2699 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750917AbWGLLA4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 07:00:56 -0400
Message-ID: <44B4D666.706@vc.cvut.cz>
Date: Wed, 12 Jul 2006 13:00:54 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Petr Vandrovec <petr@vandrovec.name>,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
References: <1152631729.3373.197.camel@pmac.infradead.org> <44B435DE.4040708@vandrovec.name> <20060712033722.GA13096@mars.ravnborg.org>
In-Reply-To: <20060712033722.GA13096@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
>>FYI, fortunately (for you, unfortunately for VMware) 2.6.18's already broke 
>>our build script due to UTS_RELEASE being moved to separate file, so from 
>>VMware's viewpoint killconfig.h.git will not do any additional damage...
> 
> #include <linux/config.h>
> #ifndef UTS_RELEASE
> #include <linux/utsrelease.h>
> #endif
> 
> Then one can wonder why WMware needs UTS_RELEASE?

To make sure user is building modules for kernel it is really using.  Without
this test users were building modules for kernels they have run years ago, and
then complained that modules do not fit to running kernel, or that kernel
crashes when they do 'insmod -f ...'...  So perl wrapper passes linux/version.h
through C preprocessor and compares resulting UTS_RELEASE with `uname -r`, and
complains loudly if they do not match.
								Petr

