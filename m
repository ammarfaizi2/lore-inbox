Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266314AbUFZRUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266314AbUFZRUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266328AbUFZRUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:20:34 -0400
Received: from [80.72.36.106] ([80.72.36.106]:30633 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S266314AbUFZRU2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:20:28 -0400
Date: Sat, 26 Jun 2004 19:20:23 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Assuming someone else called the IRQ
In-Reply-To: <200406261808.31860.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.58.0406261911530.30521@alpha.polcom.net>
References: <200406261808.31860.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jun 2004, Alistair John Strachan wrote:

> Hi,
> 
> Every kernel in the 2.6 serious so far has exhibited the same problem; after 
> some time of running my desktop system, I get:
> 
> Assuming someone else called the IRQ

Maybe it is just some debug that can be safely ignored and removed from 
source? If two or more devices share an IRQ this is normal that when IRQ  
happens all of these drivers' IRQ routine is called. So maybe one of the 
drivers checks that this is not its device and prints this debug?


>  19:    8748235   IO-APIC-level  ohci1394, yenta, eth0

Maybe you are using eth0 and yenta is printing this debug...
Do you think that assigning the same IRQ for eth0 and yenta is good idea?  
Some network cards seem to raise _many_ IRQs...

Try to grep kernel source for this string and ask the maintainer for the 
driver that produces this message.

Hope this will help a little.


Grzegorz Kulewski

