Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVHDQtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVHDQtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVHDQqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:46:35 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:14011 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262630AbVHDQpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=WaoDA/v3Z0JUM1cYmgm4SEBQG7OcYgjjyuww+S499ZRtDHXiKlwLWVXteLJKgwFGFh5xF1c40z+8Zkg7uqy+Lm5R5Uh9Ii8An73ZvNlNUDtcFjbO2YuEdvfesnyFZhEtsaciR9IWPPJE0OYijnxtvxT3pklDtWMDoSCX5fFIAzE=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] AMD64 @ K8T800/VT8237: Doubled IOAPIC-level-interrupt rate
Date: Thu, 4 Aug 2005 18:45:20 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, ak@suse.de
References: <200508041625.41296.annabellesgarden@yahoo.de> <20050804151911.GA20765@elte.hu>
In-Reply-To: <20050804151911.GA20765@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041845.20532.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 4. August 2005 17:19 schrieb Ingo Molnar:
> 
> * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> 
> > Hi,
> > 
> > this should likely be addressed to VIA Taiwan,
> > but I don't know their engineer's e-mail address and their forum
> > doesn't work for me.
> > Maybe somebody here has a clue?
> > Or maybe this is even motherboard specific?
> > 
> > To reproduce:
> > 	$ aplay -Dhw:0 -fdat /dev/zero
> > 
> > On a sane system (or here in PIC Mode) you'll see
> > around 12 Interrupts/s.
> > Here I see 24.
> 
> i think this is an effect of the 'POST-flush' symptom: the IO-APIC write 
> of unmasking the IRQ does not reach the chipset before the ACK via the 
> local-APIC does. Does it work fine if you artificially read after the 
> IO-APIC write?
> 
Sorry, I missed to say this happens on mainline .12 and .13-rcx.
In i386 and x86_64 mode.
So there is no IO-APIC (un)masking during the interrupt Routine.

I printk()ed the CPU-APIC's IRR immediately before the soundcard's
interrupt pin is deasserted and immediately after that:
The relevant IRR-bit is set again just then!

    Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
