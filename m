Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWAQBGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWAQBGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 20:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWAQBGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 20:06:15 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:50833 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751323AbWAQBGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 20:06:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=nJo18n9MqJ/abAmz1FU20Szo2nEhrqBuQTVHp9pE3cZtzT/K7ViDOBMFDDQM4L0aouShShVmYk7w2eLUAOQcNgKA+0YoUy8C21BjB4RDUnPrawI9RhPxj0crt+GDcmL+apqDbDglrq4mmu3JzbflhQ+6CI+5dwJLPf20C5SJIsM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 9/11] UML - Implement soft interrupts
Date: Tue, 17 Jan 2006 01:24:31 +0100
User-Agent: KMail/1.8.3
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org>
In-Reply-To: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601170124.32076.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 January 2006 22:39, Jeff Dike wrote:
> This patch implements soft interrupts.  Interrupt enabling and
> disabling no longer map to sigprocmask.  Rather, a flag is set
> indicating whether interrupts may be handled.  If a signal comes in
> and interrupts are marked as OK, then it is handled normally.  If
> interrupts are marked as off, then the signal handler simply returns
> after noting that a signal needs handling.  When interrupts are enabled
> later on, this pending signals flag is checked, and the IRQ handlers
> are called at that point.

~25 %? Good! Which is delay vs. host?

A curiosity - did you look at the similar code in Ingo Molnar's VCPU patch? I 
never found the time to split it out and compare differencies. I just 
remember it using assembler inserts for (maybe atomic) bitmask manipulations.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
