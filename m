Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbRGBMuM>; Mon, 2 Jul 2001 08:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbRGBMtx>; Mon, 2 Jul 2001 08:49:53 -0400
Received: from hera.cwi.nl ([192.16.191.8]:54918 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264526AbRGBMtq>;
	Mon, 2 Jul 2001 08:49:46 -0400
Date: Mon, 2 Jul 2001 14:49:11 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200107021249.OAA495880.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] more SAK stuff
Cc: andrewm@uow.edu.au, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> (a) It does less, namely will not kill processes with uid 0.
>> Ted, any objections?

Alan:

> That breaks the security guarantee. Suppose I use a setuid app to confuse
> you into doing something ?

You confuse me? Unlikely :-)

Indeed, discussion is possible. I think my version is more secure
and more useful, but if you disagree, delete the lines
                /* do not kill root processes */
                if (p->uid == 0)
                        continue;

Andries
