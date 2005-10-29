Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJ2EBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJ2EBS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 00:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJ2EBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 00:01:18 -0400
Received: from koto.vergenet.net ([210.128.90.7]:57549 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750820AbVJ2EBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 00:01:17 -0400
Date: Sat, 29 Oct 2005 12:42:58 +0900
From: Horms <horms@verge.net.au>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [SECURITY, 2.4]  Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL
Message-ID: <20051029034258.GM4961@verge.net.au>
References: <20051028092745.GL11045@verge.net.au> <1130493647.2800.17.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130493647.2800.17.camel@laptopd505.fenrus.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:00:46PM +0200, Arjan van de Ven wrote:
> On Fri, 2005-10-28 at 18:27 +0900, Horms wrote:
> > This is CAN-2005-3181, and a backport of
> > 829841146878e082613a49581ae252c071057c23 from Linus's 2.6 tree to 2.4.
> > 
> > Original Description and Sign-Off:
> > 
> > Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL
> > 
> > The nameidata "last.name" is always allocated with "__getname()", and
> > should always be free'd with "__putname()".
> > 
> > Using "putname()" without the underscores will leak memory, because the
> > allocation will have been hidden from the AUDITSYSCALL code.
> 
> > My sign off, indicating I think it applies to 2.4:
> 
> 
> since there is no such thing as CONFIG_AUDITSYSCALL in any 2.4 kernel, I
> really think this is entirely NOT relevant to 2.4.....

Thanks, I withdraw the patch.

-- 
Horms
