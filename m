Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272431AbTHFTsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272450AbTHFTsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:48:06 -0400
Received: from a.smtp-out.sonic.net ([208.201.224.38]:52122 "HELO
	a.smtp-out.sonic.net") by vger.kernel.org with SMTP id S272431AbTHFTsC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:48:02 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Wed, 6 Aug 2003 12:47:59 -0700
From: David Hinds <dhinds@sonic.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@pobox.com>, youssef@ece.utexas.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] xircom CBE2-100(faulty) hangs kernel 2.4.{21, 22-pre8} (fwd)
Message-ID: <20030806124759.C30485@sonic.net>
References: <Pine.LNX.4.44.0308061438400.4859-400000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308061438400.4859-400000@logos.cnet>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 02:39:03PM -0300, Marcelo Tosatti wrote:
> 
> ---------- Forwarded message ----------
> Date: Sat, 2 Aug 2003 16:09:30 -0500 (CDT)
> From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
> To: linux-kernel@vger.kernel.org
> Subject: [PROBLEM] xircom CBE2-100(faulty) hangs kernel 2.4.{21, 22-pre8}
> 
> 
> Hi,
> 
> I have a xircom CBE2-100 ethernet card that I know(as a matter of fact) is
> faulty. The warranty on the card expired and couldn't take it back to
> the manufacturer. Anyway, I hotplugged it into the sock with no problem at
> all. However, when I try to bring up the interface, the kernel hangs. If I
> unplug the card, the kernel comes back to life and resumes. 

Uhh... let me get this straight... the card is known for a fact to be
faulty.

> The symptoms of the problem show at
> drivers/net/pcmcia/xircom_tulip_cb: xircom_interrupt() where the interrupt
> is never acknowledge(due to flawed hardware). 

Perhaps the driver does not ack the interrupt, because the device
registers do not indicate that it requires service, and the interrupt
pin is just stuck.  Or perhaps the driver does ack and the card is
immediately re-triggering or ignoring the ack.

Drivers cannot in general diagnose hardware faults.  Perhaps, if
someone had a card broken the same way your card is broken, and they
knew the specific reason for the breakage, they could design a test
for that particular hardware fault.  But your card might be the only
one in the known universe with this particular failure mode.

-- Dave
