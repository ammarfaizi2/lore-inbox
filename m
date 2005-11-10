Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVKJTWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVKJTWy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVKJTWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:22:54 -0500
Received: from mail1.kontent.de ([81.88.34.36]:51341 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932165AbVKJTWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:22:54 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH 8/8] Inline 3 functions
Date: Thu, 10 Nov 2005 20:22:52 +0100
User-Agent: KMail/1.8
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       Pekka J Enberg <penberg@cs.helsinki.fi>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
References: <436FF51D.8080509@us.ibm.com> <200511101904.23114.oliver@neukum.org> <20051110182001.GF5376@stusta.de>
In-Reply-To: <20051110182001.GF5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511102022.52702.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 10. November 2005 19:20 schrieb Adrian Bunk:
> On Thu, Nov 10, 2005 at 07:04:22PM +0100, Oliver Neukum wrote:
> > Am Donnerstag, 10. November 2005 18:38 schrieb Adrian Bunk:
> > > > So are you suggesting that we don't mark these functions 'inline', or are
> > > > you just pointing out that we'll need to drop the 'inline' if there is ever
> > > > another caller?
> > > 
> > > I'd suggest to not mark them 'inline'.
> > 
> > It seems you have found one more use for sparse. How about a tag
> > like __single_inline that will cause a warning if a function having it
> > is called from more than one place?
> 
> Why should such a function be manually marked "inline" at all?
> 
> If a static function is called exactly once it is the job of the 
> compiler to inline the function.

It should indeed. This documentation says it does:
http://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
That makes me wonder what is the problem.

	Puzzeled
		Oliver
