Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUIULX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUIULX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUIULX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:23:26 -0400
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:4995 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267566AbUIULXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:23:25 -0400
Date: Tue, 21 Sep 2004 13:19:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
Message-ID: <20040921111900.GA7515@elf.ucw.cz>
References: <4149D243.5050501@aknet.ru> <200409162203.17988.vda@port.imtp.ilyichevsk.odessa.ua> <414B2949.700@aknet.ru> <200409180104.09796.vda@port.imtp.ilyichevsk.odessa.ua> <414C14CD.7030200@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414C14CD.7030200@aknet.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >for subsequent push/pop/call/ret operations.
> >But if code uses full ESP, thinking that upper 16 bits are zero,
> >it will crash badly. Correct me if I'm wrong.
> That's correct. But you should note that the
> program not just "thinks" that the upper 16 bits
> are zero. It writes zero there itself, and a few
> instructions later - oops, it is no longer zero...

Hmm, perhaps this can also be viewed as a "information leak"? Program
running under dosemu is not expected to know high bits of kernel
%esp...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
