Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbVIALow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbVIALow (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVIALow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 07:44:52 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:30648 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965039AbVIALow convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 07:44:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ro1ptzw9aI643zBu2pxBcysidCR1sMmPjHdhe5yKMp191GLURgrqCgEb0i7ASBf3q/HQrPin+E+A15eHPFisGCZAg6pWJHdhNfG77dMMSoqkQucPEVu/XrE72ESQws/2H4FB8W2P9WW2tcVLK1h4i1BZLW9SOmuLWFA5B3p8r3Q=
Message-ID: <aec7e5c305090104449079fc3@mail.gmail.com>
Date: Thu, 1 Sep 2005 20:44:47 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
In-Reply-To: <20050901085319.GB6285@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050830024840.GA5381@dmt.cnet>
	 <20050901085319.GB6285@isilmar.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Nice to see that this driver gets forward ported to 2.6. I originally
wrote it for pcmcia-cs, but it made its way into 2.4 after a while.
Thanks to all the people who added code and fixes.

I'm not sure how the current Linux pcmcia layer works, and I am not
involved in powerpc land anymore so I have no comments on the porting
work or the driver itself.

On 9/1/05, Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> > Russell: The driver is using pccard_nonstatic_ops for card window
> > management, even though the driver its marked SS_STATIC_MAP (using
> > mem->static_map).
> 
> This is obviously broken. Where does it fail if pccard_static_ops is used?

I remember it was interesting to write the driver for pcmcia-cs. This
was because the mpc8xx socket hardware did not implement per-window
offsets, and pcmcia-cs required that. So a wild guess is that this
static/notstatic thing is related to that.

/ magnus
