Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWILMrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWILMrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965244AbWILMrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:47:47 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:9681 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965242AbWILMrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:47:46 -0400
Date: Tue, 12 Sep 2006 13:47:42 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH] - restore i8259A eoi status on resume
Message-ID: <20060912124742.GB31344@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <200609110746.58548.ak@suse.de> <20060911110530.GA15320@srcf.ucam.org> <200609112202.50756.ak@suse.de> <20060911222351.GA23679@srcf.ucam.org> <20060911230745.GA24001@srcf.ucam.org> <20060912091906.GB19482@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060912091906.GB19482@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 11:19:06AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Got it. i8259A_resume calls init_8259A(0) unconditionally, even if 
> > auto_eoi has been set. Keep track of the current status and restore that 
> > on resume. This fixes it for AMD64 and i386.
> 
> Patch looks okay to me...

Cool. Andi, does it look sane to you? I'm not really sure who to wave 
8259 code at...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
