Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUC3Bak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263450AbUC3Baj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:30:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:47555 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263429AbUC3B2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:28:36 -0500
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20040329154330.445e10e2.pj@sgi.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	 <1080601576.6742.43.camel@arrakis> <20040329235233.GV791@holomorphy.com>
	 <20040329154330.445e10e2.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1080610052.6742.123.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 17:27:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 15:43, Paul Jackson wrote:
> My thinking on when to worry about the unused bits, and when not to, is
> thus.
> 
> For the lib/bitmap.c code, it seems that the existing standard, followed
> by everything except bitmap_complement(), is to not set any unused bits
> (at least when called with correct arguments in range), but to always
> filter them out when testing for some Boolean condition or scalar result
> (weight).

Ok...  I see why you are masking off those bits now.  Thanks for the
explanation.


> The bitmap stuff probably does more checking than I would like, but I
> felt it was more important to be consistent there, as bitmaps are an
> exposed API in their own right.  Either add unused bit zeroing and
> filtering in the remaining places (complement and the new subset and
> intersects), or rip it all out.

