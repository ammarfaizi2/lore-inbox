Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311879AbSCYCCd>; Sun, 24 Mar 2002 21:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311922AbSCYCCU>; Sun, 24 Mar 2002 21:02:20 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:31402 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S311879AbSCYCCR>;
	Sun, 24 Mar 2002 21:02:17 -0500
Date: Mon, 25 Mar 2002 13:01:13 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: Steven Walter <srwalter@yahoo.com>, alan@lxorguk.ukuu.org.uk,
        davej@suse.de, torvalds@transmeta.com, marcelo@conective.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Screen corruption in 2.4.18
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	alan@lxorguk.ukuu.org.uk, davej@suse.de, torvalds@transmeta.com,
	marcelo@conective.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <20020324071604.GA15618@hapablap.dyn.dhs.org> <200203241231.g2OCV5X18426@Port.imtp.ilyichevsk.odessa.ua> <20020324155930.GA20926@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Message-Id: <1017021673.923717.13530.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 09:59:30AM -0600, Steven Walter wrote:

> Here is a patch which should apply cleanly to everyone's tree, which
> only clears bit 7 on all chips except the KT266.  No problems have been
> reported there, so I'm leaving well enough alone.  Please apply.

I don't think the patch should be that generic; we're into dragon
territory here already.  We should follow VIA's fix by default
(clear bits 5, 6, 7), and clear bit 7 only if a VT8365 is
detected.

Even then, I personally want to do some checking to see that the
VT8365 is the real culprit, before firing off a patch which could
affect all other VIA users.  I don't want hate mail coming into
my inbox 8).


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
