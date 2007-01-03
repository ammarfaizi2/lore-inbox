Return-Path: <linux-kernel-owner+w=401wt.eu-S1753604AbXACCUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604AbXACCUl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 21:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753638AbXACCUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 21:20:41 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:2226 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593AbXACCUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 21:20:40 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: kernel + gcc 4.1 = several problems
Date: Wed, 3 Jan 2007 02:20:24 +0000
User-Agent: KMail/1.9.5
Cc: torvalds@osdl.org, 76306.1226@compuserve.com, akpm@osdl.org,
       bunk@stusta.de, greg@kroah.com, linux-kernel@vger.kernel.org,
       yanmin_zhang@linux.intel.com
References: <200701030212.l032CDXe015365@harpo.it.uu.se>
In-Reply-To: <200701030212.l032CDXe015365@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701030220.24897.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 January 2007 02:12, Mikael Pettersson wrote:
> On Tue, 2 Jan 2007 17:43:00 -0800 (PST), Linus Torvalds wrote:
> > > The suggestions I've had so far which I have not yet tried:
> > >
> > > -	Select a different x86 CPU in the config.
> > > 		-	Unfortunately the C3-2 flags seem to simply tell GCC
> > > 			to schedule for ppro (like i686) and enabled MMX and SSE
> > > 		-	Probably useless
> >
> > Actually, try this one. Try using something that doesn't like "cmov".
> > Maybe the C3-2 simply has some internal cmov bugginess.
>
> That's a good suggestion. Earlier C3s didn't have cmov so it's
> not entirely unlikely that cmov in C3-2 is broken in some cases.
> Configuring for P5MMX or 486 should be good safe alternatives.

Or just C3 (not C3-2), which is what I've done.

I'll report back whether it crashes or not.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
