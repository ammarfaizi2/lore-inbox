Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTFPA7q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTFPA7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:59:46 -0400
Received: from fe1.rdc-kc.rr.com ([24.94.163.48]:23308 "EHLO mail1.kc.rr.com")
	by vger.kernel.org with ESMTP id S263185AbTFPA7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:59:45 -0400
Date: Sun, 15 Jun 2003 20:13:35 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lost interrupts with 2.4.21 and i875p chipset -- resolved (maybe)
Message-ID: <20030616011335.GA1504@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030603111519.GA23228@glitch.localdomain> <20030603234359.GA690@glitch.localdomain> <20030604002911.GA1379@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604002911.GA1379@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 06:43:59PM -0500, Greg Norris wrote:
> > Does this occur if you build the kernel without ACPI and without APIC
> > support ?
>
> I just finished testing rc7, and sure enough the problem disappears
> after disabling APIC.  Thanx!

I built a SMP kernel earlier today (in order to enable hyperthreading),
and discovered that the lost interrupt problem appears to have gone
away.  In addition, dmesg no longer shows any "unexpected IO-APIC"
messages.  The only configuration changes from the previous kernel are:

   CONFIG_SMP=y
   CONFIG_ACPI=y
   CONFIG_ACPI_BUSMGR=y
   CONFIG_ACPI_CPU=y

I guess that the next step is to disable hyperthreading in the BIOS,
and see if the UP kernel still has problems.
