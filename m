Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRK3Xit>; Fri, 30 Nov 2001 18:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283831AbRK3Xij>; Fri, 30 Nov 2001 18:38:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13832 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S283828AbRK3XiW>; Fri, 30 Nov 2001 18:38:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] task_struct colouring ...
Date: 30 Nov 2001 15:37:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9u958c$ets$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.40.0111301326160.1600-100000@blue1.dev.mcafeelabs.com> <E169wL1-00052x-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E169wL1-00052x-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > Looking at both the Manfred and Fujitsu patches I propose this new version
> > for task struct colouring.
> > The patch from Manfred is too architecture dependent ( cr2 ) and storing
> > extra stuff in CPU registers is not IMHO a good idea.
> 
> Well the whole "current" handling is entirely architecture dependant anyway.
> On most saner platforms current is a global register variable (the wonders
> of gcc) and the whole problem simply isnt there
> 

Using %cr2 was pretty broken, but I liked the patch using %tr.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
