Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbTFBTYV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTFBTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:24:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:25351 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262456AbTFBTYT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:24:19 -0400
Date: Mon, 2 Jun 2003 21:37:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Message-ID: <20030602193739.GB10750@alpha.home.local>
References: <fa.hnjaa1v.19gukhb@ifi.uio.no> <fa.h2i5rk8.1c3cq0m@ifi.uio.no> <bbfvik$24e$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbfvik$24e$1@ID-44327.news.dfncis.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Mon, Jun 02, 2003 at 06:55:48PM +0200, Andreas Hartmann wrote:
> Michael Frank wrote:
<...>
> > GNU bash, version 2.05b.0(1)-release (i386-redhat-linux-gnu)
> 
> 2.02.1(1)-release
<...>
> > -   while (( i-- )); do
> > +   while (( i=`expr $i - 1` )); do
> > 
> > In your opinion are your changes more portable across a wide range of
> > systems?
> 
> I didn't think at portability :-). I only made it working for me. Maybe
> there are other persons out there who do have some old versions too - so
> they can use this patch.

Well, I found that i--/i++ don't work with bash-2.03 (present about everywhere)
but i=i-1 or i=i+1 work well. So at least, for portability, this could be
rewritten as "while (( i=i-1 )); do".

Cheers,
Willy

