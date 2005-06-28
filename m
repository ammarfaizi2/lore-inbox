Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVF1QoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVF1QoS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVF1QoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:44:18 -0400
Received: from [212.76.85.206] ([212.76.85.206]:39940 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261780AbVF1QoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:44:00 -0400
Message-Id: <200506281643.TAA00504@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Paulo Marques'" <pmarques@grupopie.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Tue, 28 Jun 2005 19:43:20 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050628095815.GA13464@logos.cnet>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV79vRBJTZRcuw5QaCtBDnDuFTlJAACTP5w
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote: {
On Tue, Jun 28, 2005 at 03:55:29PM +0100, Paulo Marques wrote:
> Al Boldi wrote:
> >On Mon, Jun 27, 2005 at 11:04:08PM +0300, Al Boldi wrote:
> >
> >>In 2.4.31 kswapd starts paging during OOMs even w/o swap enabled.
> >>
> >>Is there a way to fix/disable this behaviour?
> >
> >
> >Marcelo,
> >
> >Kswapd starts evicting processes to fullfil a malloc, when it should 
> >just deny it because there is no swap.
> 
> I think what you really want is to adjust your "overcommit" settings.
> 
> See: "Documentation/vm/overcommit-accounting"

You might also want to disable the OOM killer (CONFIG_OOM_KILLER).
}

Paulo,
Thanks for the pointer!  Overcommit is the problem, and kswapd is not
honoring it.
Can this be fixed/adjusted?

Marcelo,
Disable OOM killer? Is that an option in 2.4 or 2.6?

Thanks!

