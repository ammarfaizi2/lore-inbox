Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVDUKCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVDUKCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 06:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVDUKB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 06:01:28 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:58899 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S261243AbVDUJ7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:59:21 -0400
Date: Wed, 20 Apr 2005 21:47:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Domen Puncer <domen@coderock.org>
Cc: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
       mpm@selenic.com
Subject: Re: [PATCH] introduce generic 64bit rotations and i386 asm optimized version
Message-ID: <20050420204707.GC4551@linux-mips.org>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <20050419.154642.111848378.yoshfuji@linux-ipv6.org> <20050419202037.GE21272@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419202037.GE21272@nd47.coderock.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 10:20:38PM +0200, Domen Puncer wrote:

> > Please keep using __inline__, not inline.
> 
> Why?
> 
> Couldn't find any threads about this, and even SubmittingPatches has:
> "'static inline' is preferred over 'static __inline__'..."

Unlike inline __inline__ will be recogniced by gcc even in -ansi mode.
And inline is namespace pollution.  Where there's no technical reason I
prefer the non-underscore version, __inline__ is just looking too 1337
and eye-insulting.

Of course all these thoughts are useless because these days usespace is
not supposed to use kernel headers directly and the kernel isn't ANSI-clean
anyway.

  Ralf
