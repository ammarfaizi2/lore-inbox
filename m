Return-Path: <linux-kernel-owner+w=401wt.eu-S932153AbXACWRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbXACWRD (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbXACWRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:17:01 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55259 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932153AbXACWRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:17:00 -0500
Date: Wed, 3 Jan 2007 14:13:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Grzegorz Kulewski <kangur@polcom.net>, Alan <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@it.uu.se>, s0348365@sms.ed.ac.uk,
       76306.1226@compuserve.com, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701032248.38653.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.64.0701031411350.4473@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <200701032047.02941.vda.linux@googlemail.com> <Pine.LNX.4.64.0701031225090.4473@woody.osdl.org>
 <200701032248.38653.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jan 2007, Denis Vlasenko wrote:
> 
> IOW: yet another slot in instruction opcode matrix and thousands of
> transistors in instruction decoders are wasted because of this
> "clever invention", eh?

Well, in all fairness, it can probably help more on certain 
microarchitectures. Intel is fairly aggressively OoO, especially in Core 
2, and predicted branches are not only free, they allow OoO to do a great 
job around them. But an in-order architecture doesn't have that, and cmov 
might show more of an advantage there.

		Linus
