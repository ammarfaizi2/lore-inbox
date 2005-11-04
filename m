Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbVKDAuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbVKDAuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVKDAt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:49:57 -0500
Received: from ffm.saftware.de ([217.20.127.95]:7689 "EHLO ffm.saftware.de")
	by vger.kernel.org with ESMTP id S1161011AbVKDAt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:49:29 -0500
Subject: Re: [linux-dvb-maintainer] Re: [PATCH 26/37] dvb: add support for
	plls used by nxt200x
From: Andreas Oberritter <obi@linuxtv.org>
To: Manu Abraham <manu@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, Mike Krufky <mkrufky@linuxtv.org>,
       linux-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <436AA148.8090705@linuxtv.org>
References: <4367241A.1060300@m1k.net>
	 <20051103135910.3bf893d9.akpm@osdl.org> <436A96A8.4080906@linuxtv.org>
	 <436AA148.8090705@linuxtv.org>
Content-Type: text/plain
Date: Fri, 04 Nov 2005 01:51:08 +0100
Message-Id: <1131065468.9376.23.camel@ip6-localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 03:46 +0400, Manu Abraham wrote:
> We have in the DVB subsystem most of the exported symbols as 
> EXPORT_SYMBOL itself, rather than EXPORT_SYMBOL_GPL. I think if this 
> needs to be changed, we would require a global change of all symbols to 
> the same to maintain consistency. If you require that change we can have 
> a change but i would think that the discussions be done with the 
> relevant copyright holders too, eventhough probably most of the authors 
> won't have any objection.

I don't know if I ever contributed code to the DVB subsystem which is
actually exported, but in case I did, then I am against changing the
affected EXPORT_SYMBOLs.

This would make it impossible to the use source code of most hardware
vendors for embedded products because they usually have different
licenses for their "run-on-every-embedded-platform-and-even-on-windows"
drivers.

Also I remember people telling on lkml that EXPORT_SYMBOL_GPL was used
for new kernel internal code only and I can't see how this applies to
dvb-pll or any other part of the dvb subsystem which grew up outside the
kernel tree.

Regards,
Andreas

