Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWGLNyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWGLNyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 09:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWGLNyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 09:54:38 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:28866 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751374AbWGLNyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 09:54:37 -0400
Message-ID: <44B4FF1C.4020100@vc.cvut.cz>
Date: Wed, 12 Jul 2006 15:54:36 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Sam Ravnborg <sam@ravnborg.org>, Petr Vandrovec <petr@vandrovec.name>,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT *] Remove inclusion of obsolete <linux/config.h>
References: <1152631729.3373.197.camel@pmac.infradead.org>	 <44B435DE.4040708@vandrovec.name>	 <20060712033722.GA13096@mars.ravnborg.org>  <44B4D666.706@vc.cvut.cz> <1152708689.3217.36.camel@laptopd505.fenrus.org>
In-Reply-To: <1152708689.3217.36.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-07-12 at 13:00 +0200, Petr Vandrovec wrote:
> 
>>Sam Ravnborg wrote:
>>
>>To make sure user is building modules for kernel it is really using.  Without
>>this test users were building modules for kernels they have run years ago, and
>>then complained that modules do not fit to running kernel, or that kernel
>>crashes when they do 'insmod -f ...'...  So perl wrapper passes linux/version.h
>>through C preprocessor and compares resulting UTS_RELEASE with `uname -r`, and
>>complains loudly if they do not match.
> 
> isn't this exactly what VERMAGIC is for instead?

In newer kernels only.  We still support 2.2.x kernels, and to find kernel version
you have to parse some kernel headers...  And unfortunately vermagic mismatch is
printed into `dmesg` only, so it takes several iterations until customer is able
to pinpoint problem down (to 586/686 mismatch, for example).
								Petr

