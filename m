Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUFZRmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUFZRmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUFZRmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:42:19 -0400
Received: from smtp809.mail.ukl.yahoo.com ([217.12.12.199]:1181 "HELO
	smtp809.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S267194AbUFZRmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:42:04 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: Assuming someone else called the IRQ
Date: Sat, 26 Jun 2004 18:42:45 +0100
User-Agent: KMail/1.6.52
References: <200406261808.31860.s0348365@sms.ed.ac.uk> <Pine.LNX.4.58.0406261911530.30521@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0406261911530.30521@alpha.polcom.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406261842.45973.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 June 2004 18:20, you wrote:
> On Sat, 26 Jun 2004, Alistair John Strachan wrote:
> > Hi,
> >
> > Every kernel in the 2.6 serious so far has exhibited the same problem;
> > after some time of running my desktop system, I get:
> >
> > Assuming someone else called the IRQ
>
> Maybe it is just some debug that can be safely ignored and removed from
> source? If two or more devices share an IRQ this is normal that when IRQ
> happens all of these drivers' IRQ routine is called. So maybe one of the
> drivers checks that this is not its device and prints this debug?

Yes, this sounds about right. It's the prism54 driver, as Russell identified 
in another reply.

>
> >  19:    8748235   IO-APIC-level  ohci1394, yenta, eth0
>
> Maybe you are using eth0 and yenta is printing this debug...
> Do you think that assigning the same IRQ for eth0 and yenta is good idea?
> Some network cards seem to raise _many_ IRQs...
>

Since the card is a PCMCIA prism3 card in a cardbus adaptor, any interrupt 
sent to yenta will be destined for the eth0 wireless card. It's not really a 
problem, I was just putting the driver under duress because I had the 
firewire controller heavily loaded.

Unfortunately these nForce2 boards crammed full of on-board hardware typically 
assign at least firewire and the AGP slot IRQ 19, and the PCI slot I've got 
the cardbus adaptor in is also sharing this IRQ line. I can't really do 
anything about it, I'm afraid to say.

Thanks for the reply Grzegorz.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
