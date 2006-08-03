Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbWHCUS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWHCUS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWHCUS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:18:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964826AbWHCUSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:18:25 -0400
Date: Thu, 3 Aug 2006 16:17:17 -0400
From: Dave Jones <davej@redhat.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Userspace visible of 3 include/asm/ headers
Message-ID: <20060803201717.GG16927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alexey Dobriyan <adobriyan@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
References: <20060803193952.GF25692@stusta.de> <20060803194410.GC16927@redhat.com> <20060803201402.GA6828@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803201402.GA6828@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:14:02AM +0400, Alexey Dobriyan wrote:
 > On Thu, Aug 03, 2006 at 03:44:10PM -0400, Dave Jones wrote:
 > > On Thu, Aug 03, 2006 at 09:39:52PM +0200, Adrian Bunk wrote:
 > >  > Could anyone help me regarding the desired userspace visibility of the
 > >  > following three headers under include/asm/?
 > >  >
 > >  > Header        : cpufeature.h
 > >  > Architectures : i386, x86_64
 > >  > Is there any reason why this header is exported to userspace?
 > >
 > > Probably not. The only apps I've seen that care about feature bits
 > > define them theirselves rather than use these.
 > 
 > Feature bits are only (indirectly) visible via /proc/cpuinfo.
 > struct cpuinfo_x86, AFAICS, is never copied to userspace. So, it's safe
 > to remove this header.

Most of the bits (all but the linux specific ones), are the same bits you
can get from /dev/cpu/0/cpuid, or from calling the cpuid instruction by hand.

		Dave

-- 
http://www.codemonkey.org.uk
