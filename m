Return-Path: <linux-kernel-owner+w=401wt.eu-S1161136AbXAEQGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161136AbXAEQGR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbXAEQGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:06:16 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37355 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161136AbXAEQGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:06:16 -0500
Date: Fri, 5 Jan 2007 08:02:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Mikael Pettersson <mikpe@it.uu.se>, 76306.1226@compuserve.com,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, yanmin_zhang@linux.intel.com
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <200701051553.04673.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.64.0701050757320.3661@woody.osdl.org>
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
 <200701030220.24897.s0348365@sms.ed.ac.uk> <200701051553.04673.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jan 2007, Alistair John Strachan wrote:
> 
> This didn't help. After about 14 hours, the machine crashed again.
> 
> cmov is not the culprit.

Ok. Have you ever tried to limit the drivers you have loaded? I notice you 
had the prism54 wireless thing in your modules list and the vt1211 hw 
monitoring thing. I'm wondering about the vt1211 thing - it probably isn't 
too common. But if you can use that machine without the wireless too, it 
might be good to try without either.

(The rest of your module list looked bog-standard, so if it's not 
hardware-specific, I don't think it's there)

Turning of the VIA sound driver just in case would be good too.

The reason I mention vt1211 in particular is that it does things like 
regulate fan activity etc. Is the problem perhaps heat-related? 

		Linus
