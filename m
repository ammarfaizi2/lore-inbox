Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTEMVj1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbTEMVj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:39:26 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:54709 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262001AbTEMVjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:39:24 -0400
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on
	card release while shutting down
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: alexander.riesen@synopsys.COM, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052839860.2255.19.camel@diemos>
References: <20030513135759.GG32559@Synopsys.COM>
	 <1052837896.1000.2.camel@teapot.felipe-alfaro.com>
	 <1052839860.2255.19.camel@diemos>
Content-Type: text/plain
Message-Id: <1052862721.2410.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 23:52:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 17:31, Paul Fulghum wrote:
> > Don't know if this is fixed by latest Russell patches, but vanilla and
> > -bk snapshots do *not* contain the latest PCMCIA/CardBus code. Is it
> > possible for you to try 2.5.69-mm4?
> 
> Russell's patches do not address this.

I knew I were no expert on this... ;-)

> Individual PCMCIA drivers need to be updated to call
> thier release function directly when processing a
> CARD_RELEASE message instead of from a timer procedure.

Aha! I got you! Thanks.

