Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVKBNda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVKBNda (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbVKBNda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:33:30 -0500
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:50604 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965013AbVKBNd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:33:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=HOPH/kFdokfWtpSJ2norv0UdpRABLRZnQG4TLUgp7xnmmvhBG9Isn+nj8U5gKL7KuUke63l9kuaB5AoEYCroIdwjLbNvNyvv3gCJKLcd6ZEKqfOzmTEKLqhfg0WikMn1kAbidv3eQfrAwrQeXeOdiqUMzoAcxmo4xja0XGwOMZ0=  ;
Date: Wed, 2 Nov 2005 14:33:28 +0100
From: Borislav Petkov <bbpetkov@yahoo.de>
To: David Brownell <david-b@pacbell.net>
Cc: Borislav Petkov <bbpetkov@yahoo.de>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
Message-ID: <20051102133328.GA16365@gollum.tnic>
References: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com> <200510311624.31680.david-b@pacbell.net> <20051101112321.GA8691@gollum.tnic> <200511011018.05117.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011018.05117.david-b@pacbell.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 10:18:04AM -0800, David Brownell wrote:
> On Tuesday 01 November 2005 3:23 am, Borislav Petkov wrote:
> > Yeah, the symptoms are really weird. Let me rehash the whole history:
> > First, we did some testing with 2.6.14-rc4, _with_ the patch and the
> > 'handoff' cmd option and it worked. Then, several boots later, I noticed
> > that it started hanging itself again at the same position not while rebooting 
> > but at _initial_ boot in the morning. ...
> 
> So you're saying your hardware doesn't act consistently.
> Is there a BIOS update you can try?  The failure sure seems
> to be board-specific.
Just did a BIOS update - the 2.6.14 git version from yesterday booted
just fine.
> 
> 
> > ... 2.6.13, in contrast, boots just fine. Hope
> > that helps,
> 
> Well that's news, and not mentioned in the bug report; in fact, you
> said explicitly that it _never_ worked on earlier kernels (see your
> comment #2).
Ups, my bad, i got kinda confused by the formulation "most recent kernel 
where..", sorry.

> This means you could use "git bisect" to point a finger at a patch that,
> if it doesn't actually cause the problem, at least surfaces a latent bug
> in other code.  Could you please try that?
> 
> I'm starting to suspect some IRQ setup problem here; those are classically
> issues in ACPI code, even when the breakage shows only with USB.
This is superfluous, I guess, now that 2.6.14 boots.

Thanks for your help.

Regards,
		Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
