Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbWKAPWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbWKAPWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbWKAPWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:22:16 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:32646 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750993AbWKAPWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:22:15 -0500
Date: Wed, 1 Nov 2006 15:22:01 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm1: noidlehz problems
Message-ID: <20061101152201.GA13634@srcf.ucam.org>
References: <20061101122319.GA13056@elf.ucw.cz> <1162386177.23744.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162386177.23744.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 02:02:57PM +0100, Arjan van de Ven wrote:

> In some (hardware) C-states, the local apic timer stops (as does the
> TSC), while in others it keeps running. If you change from AC to
> battery, the bios can change the meaning of a software C-state from one
> where local apic timer keeps going to one where it stops. This obviously
> upsets the hrtimers/tickless code since that uses local apic timer for
> event generation....

Is there any hope of working around this? I'd have expected that the 
most useful case for the tickless code was also the case where we want 
to be using C3/C4...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
