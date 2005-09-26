Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751691AbVIZR3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbVIZR3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbVIZR3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:29:32 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:37494 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751691AbVIZR3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:29:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=SK/AVI/Y7upgwLTHJRfK8Kfxm3S+PaEqQvs8xfmp8cVDyh98GOoTVuZjHh2TeNGmBZPySHXSj2sLHyqZmb9kZ9bizFFW9rqnnacDtC3lSCtwSDM7pUGT8A8dPfbSpoljk6TgDRM7zK4OnpgDGa5IFv84YrZ1NXyKqdfHi1Pyvz8=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH/RFC] Enable HPET on VIA8237 southbridge
Date: Mon, 26 Sep 2005 19:34:03 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <1127749798.433818a676435@domainfactory-webmail.de>
In-Reply-To: <1127749798.433818a676435@domainfactory-webmail.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261934.03876.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. September 2005 17:49 schrieb Clemens Ladisch:
> Karsten Wiese wrote:
> > if you have that chip on your mainboard and want to play with it's
> > hpet, this might get you going.
> 
> I'm using similar code for my ICH5 southbridge, but I patched
> arch/i386/kernel/acpi/boot.c instead so that the kernel can use it
> for its own purposes.

The kernel uses the hpet here too with my patch.
Please send me your acpi/boot.c patch.

I guess you setup an ACPI_HPET entry, if none has been found?
Maybe your approach is safer/better, 'cause you can scan other ACPI
assigned Hardware addresses there.
> 
> > One exception: Timer1 says it can do PERIODIC mode,
> > but this doesn't work here. One shot is ok.
> 
> This may be because your patch doesn't initialize the interrupt
> routing registers (which would have been the BIOS' job).

No. Interrupt works fine (IRQ 8). Reliably @10000/s.

   Regards,
   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
