Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWCZMdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWCZMdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCZMdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:33:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15766 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751327AbWCZMdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:33:43 -0500
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header
	infrastructure
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
In-Reply-To: <20060326065416.93d5ce68.mrmacman_g4@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	 <200603231811.26546.mmazur@kernel.pl>
	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <20060326065416.93d5ce68.mrmacman_g4@mac.com>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 14:32:31 +0200
Message-Id: <1143376351.3064.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 06:54 -0500, Kyle Moffett wrote:
> Create initial kernel ABI header infrastructure


it's nice that you picked this one;
for this you want an arch-generic/stddef32.h and stddef64.h

and have arch-foo just only include the proper generic one..

(and... why do you prefix these with _KABI? that's a mistake imo. Don't
both with that. Really. Either these need exporting to userspace, but
then either use __ as prefix or don't use a prefix. But KABI.. No.)


