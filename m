Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbTESSJY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTESSJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:09:24 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:31039 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262593AbTESSJW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:09:22 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305191235470.655-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305191235470.655-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053368413.1995.9.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 19 May 2003 13:20:14 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 11:41, Alan Stern wrote:
> The patch below incorporates your suggested subroutine.  That alone wasn't
> enough to prevent the state from bouncing a few times when I powered my
> USB device on or off, so the debounce code is in there too.  This patch
> behaves fine on my workstation, which has both ports connected.  I'll try
> it later on my laptop, which only has one port.
> 
> In the end, I decided it was easiest and safest to follow your "don't 
> suspend if any ports are OC" scheme.  We can try it the other way too if 
> you want.  What do you think would happen if you were to try to put your 
> machine in an APM/ACPI "suspend" state?
> 
> This is a cumulative patch, i.e., it applies to a virgin 2.5.69 source.  
> Let me know how it works for you.

Alan,

the patch applied cleanly and worked for me
(prevented global suspension). Having the lengthy
waits outside of the ISR is a definate plus, and
the debounce makes sense.

My machine does not have APM/ACPI facilities so
I can't test the suspend. It is getting pretty
dated, but the economy dictates I live with it for
a while longer :-)

Does you laptop use the PIIX4? If it does and uses only
one port, I would be very interested to see if
one port is continuously reporting OC (hardwired).

Thanks for the patch,
Paul

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


