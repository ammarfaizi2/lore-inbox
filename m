Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWHCTpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWHCTpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWHCTpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:45:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58779 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030211AbWHCTpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:45:20 -0400
Date: Thu, 3 Aug 2006 15:44:10 -0400
From: Dave Jones <davej@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Userspace visible of 3 include/asm/ headers
Message-ID: <20060803194410.GC16927@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>
References: <20060803193952.GF25692@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803193952.GF25692@stusta.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 09:39:52PM +0200, Adrian Bunk wrote:
 > Could anyone help me regarding the desired userspace visibility of the 
 > following three headers under include/asm/?
 > 
 > 
 > Header        : cpufeature.h
 > Architectures : i386, x86_64
 > Is there any reason why this header is exported to userspace?

Probably not. The only apps I've seen that care about feature bits
define them theirselves rather than use these.

 > Header        : setup.h
 > Architectures : i386, ia64, x86_64
 > Contents:
 > - COMMAND_LINE_SIZE on ia64, x86_64
 > - much more on i386
 > Should COMMAND_LINE_SIZE be visible to userspace?

Bootloaders probably need to know this.

 > Header        : timex.h
 > Architectures : all architectures
 > Offers CLOCK_TICK_RATE on all architectures, but on some architectures
 > (like i386) this depends on the kernel configuration.
 > -> not a userspace header?

Also longer term,  CLOCK_TICK_RATE will make no sense should we go
to a tickless kernel.

		Dave

-- 
http://www.codemonkey.org.uk
