Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSL2UC3>; Sun, 29 Dec 2002 15:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSL2UC2>; Sun, 29 Dec 2002 15:02:28 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:9468 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261594AbSL2UC1>; Sun, 29 Dec 2002 15:02:27 -0500
Date: Sun, 29 Dec 2002 15:10:49 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Workaround for AMD762MPX "mouse" bug
Message-ID: <20021229151049.A16750@redhat.com>
References: <20021224162501.GA5363@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021224162501.GA5363@averell>; from ak@muc.de on Tue, Dec 24, 2002 at 05:25:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 05:25:01PM +0100, Andi Kleen wrote:
> way would be to always reserve that page, but I didn't feel like
> punishing everybody just for a hardware bug in a single chipset.
> 
> Patch for 2.5.53. Please consider applying.

That's the wrong way to do it.  Workarounds like this need to be automatic, 
and with init code sections, there is no excuse not to.  Instead of making 
the user pass a quirk option, why not reserve the page and then free it if 
the errata is not present?

		-ben
