Return-Path: <linux-kernel-owner+w=401wt.eu-S1751821AbXAOGFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXAOGFG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 01:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbXAOGFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 01:05:06 -0500
Received: from 81-174-33-43.f5.ngi.it ([81.174.33.43]:35688 "EHLO develer.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXAOGFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 01:05:03 -0500
X-Spam-Virus: No
Message-ID: <45AB196B.7090409@develer.com>
Date: Mon, 15 Jan 2007 07:04:27 +0100
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l. - http://www.develer.com/
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, aleph <aleph@develer.com>
Subject: Re: [Linux-fbdev-devel] How to mmap a shadow framebuffer in virtual
 memory
References: <45A97832.2040206@develer.com> <Pine.LNX.4.62.0701141211030.18479@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0701141211030.18479@pademelon.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-DSPAM-Result: Whitelisted
X-DSPAM-Processed: Mon Jan 15 07:04:53 2007
X-DSPAM-Confidence: 0.9996
X-DSPAM-Probability: 0.0000
X-DSPAM-Signature: 45ab1985318824178781303
X-DSPAM-Factors: 27,
	Subject*to+mmap, 0.00010,
	Organization*http+www, 0.00010,
	which+copies, 0.00010,
	Received*217.133.10.139, 0.00010,
	Received*217.133.10.139, 0.00010,
	CC*lkml+linux, 0.00010,
	CC*lkml, 0.00010,
	Organization*www, 0.00010,
	Geert+Uytterhoeven, 0.00010,
	Subject*fbdev, 0.00010,
	Develer+S, 0.00010,
	pages+instead, 0.00010,
	Uytterhoeven, 0.00010,
	Received*217-133-10-139.b2b.tiscali.it, 0.00010,
	CC*aleph+aleph, 0.00020,
	CC*com, 0.00035,
	driver+which, 0.00037,
	Organization*http, 0.00037,
	Organization*S, 0.00044,
	Url*linux, 0.00046,
	Url*linux, 0.00046,
	CC*net, 0.00049,
	wrote+It's, 0.00051,
	CC*develer+com, 0.00051,
	CC*develer, 0.00051,
	Url*git, 0.00065,
	Url*git, 0.00065
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:

> It's known to work for the PS3 frame buffer device driver, which copies the
> virtual frame buffer to the GPU on every vsync. Check out ps3fb_mmap() in
> http://www.kernel.org/git/?p=linux/kernel/git/geoff/ps3-linux.git;a=blob_plain;f=drivers/video/ps3fb.c;hb=HEAD

I still couldn't solve my problem, but thanks for helping.

The way you map memory in ps3fb_mmap() is basically the same.
In my case, memory is allocated with __get_free_pages() instead
of being at an absolute physical address, but I can't see how
it could make any difference.

-- 
   // Bernardo Innocenti - Develer S.r.l., R&D dept.
 \X/  http://www.develer.com/
