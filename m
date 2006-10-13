Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWJMGTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWJMGTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 02:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWJMGTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 02:19:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:39555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751170AbWJMGTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 02:19:00 -0400
X-Authenticated: #14349625
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
From: Mike Galbraith <efault@gmx.de>
To: nmeyers@vestmark.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061013004918.GA8551@viviport.com>
References: <20061013004918.GA8551@viviport.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 08:25:12 +0000
Message-Id: <1160727912.15431.11.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 20:49 -0400, nmeyers@vestmark.com wrote:

> I tried Catalin Marinas' kmemleak patches, and had to rebuild with
> GCC 3.4.6 because of a 4.1.1 compiler bug that prevents compilation
> of the patches.

Yeah, seems any remotely recent gcc hates it.  That puts a rather large
dent in usability.

> And... building with 3.4.5 fixed the leak! So I guess I have very little
> detail to report - except that there's a nasty leak in 2.6.17 when built
> with 4.1.1.

If you build using 3.4.5 _without_ the kmemleak patches, do you see the
leak again?  (ie is kmemleak altering timing, or is kernel miscompiled)

> If anyone has a version of kmemleak that I can build with 4.1.1, or
> any other suggestions for instrumentation, I'd be happy to gather more
> data - the problem is very easy for me to reproduce.

I can only suggest trying latest/greatest to see if the issue is still
present, and if so, try to find a way that others may trigger it.

	-Mike

