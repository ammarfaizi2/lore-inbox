Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVKKDq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVKKDq4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVKKDq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:46:56 -0500
Received: from drizzle.CC.McGill.CA ([132.206.27.48]:4250 "EHLO
	drizzle.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id S932327AbVKKDqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:46:55 -0500
Subject: Re: Serious IDE problem still present in 2.6.14
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
Reply-To: David.Ronis@mcgill.ca
To: Stefan <gentoopower@yahoo.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436A9C30.3080705@yahoo.de>
References: <Pine.LNX.4.44.0510301030120.26176-100000@coffee.psychology.mcmaster.ca>
	 <1130689871.6348.3.camel@montroll.chem.mcgill.ca>
	 <4365511C.7040903@yahoo.de>
	 <1130713716.6348.7.camel@montroll.chem.mcgill.ca>
	 <4365596F.4060105@yahoo.de>
	 <1130785344.5932.6.camel@montroll.chem.mcgill.ca>
	 <43673DFE.4000702@yahoo.de>
	 <1131022436.6016.4.camel@montroll.chem.mcgill.ca>
	 <436A9C30.3080705@yahoo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Chemistry, McGill University
Date: Thu, 10 Nov 2005 22:46:33 -0500
Message-Id: <1131680793.6300.20.camel@montroll.chem.mcgill.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been busy and have been a bit late responding to this.  In short,
have a problem with disk performance on a HP Pavilion laptop in the
2.6.1[34] kernels (it works fine under 2.6.12.x).  I've summarized much
of the tests I've run on in a post to linux-kernel and linux-ide (when
we thought it was a problem in the ATIIXP module) at:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=112802950411697&w=2

After working with Stefan for a bit, we determined that the problem is
in the ACPI modules (in fact setting ACPI=ht at boot fixes it, although
other things seem to break, as described below).  Stefan suggested I
repost the bug to the linux-kernel list, and so here it is.

David

On Fri, 2005-11-04 at 00:24 +0100, Stefan wrote:
> David Ronis wrote:
> 
> >Hi Stefan,
> >
> >Did you receive my e-mail with the results of your suggestion?
> >  
> >
> Ah sometimes yahoo marks some mails from the list as spam.
> 
> Anyways, I just looked through the changelog from 2.6.12 to 2.6.13, lots
> of acpi changes.
> It looks like the problem is within the acpi code.
> 
> Just send another mail to linux-kernel kernel list instead of linux-ide
> and tell them about your problem.
> 
> I'd send along the hdparm tests 'hdparm /dev/hda' + 'hdparm -i /dev/hda'
> with both kernels and the 'dmesg' output of both + 'lspci -vv'
> 
> To my believe it is unlikely, that any changes in the drivers for ide or
> atiixp are responsible for your performance loss.
> 
> >I've been playing around a bit more; specifically, I tried booting with 
> >apci=ht (without noapic) as was suggested by someone from my earlier
> >post on the linux-kernel list.  This alone seems to fix the problem (as
> >did your suggestion).  Now however, X doesn't work because 
> >
> >"The /dev/input/event* device nodes seem to be missing"
> >
> >I don't know if your suggestion gives the same problem, but my bet is
> >that it does.  
> >
> >Anyhow, if you didn't receive my last e-mail, I'll resend it (it has the
> >output of dmesg as well as some timings).
> >
> >Thanks again.
> >
> >David
> >
> >
> >On Tue, 2005-11-01 at 11:05 +0100, Stefan wrote:
> >  
> >
> >>Lets try something different,
> >>
> >>boot your machine with those arguments:
> >>
> >>noapic acpi=off
> >>
> >>If you use grub, just press e to edit the boot command and add these
> >>flags to the existing line which boots your kernel.
> >>Lets see if this makes any performance difference
> >>
> >>	
> >>
> >>	
> >>		
> >>___________________________________________________________ 
> >>Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
> >>
> >>    
> >>
> >
> >  
> >
> 
> 
> 	
> 
> 	
> 		
> ___________________________________________________________ 
> Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
> 
