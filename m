Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTFDAQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFDAP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:15:59 -0400
Received: from fe5.rdc-kc.rr.com ([24.94.163.52]:29956 "EHLO mail5.kc.rr.com")
	by vger.kernel.org with ESMTP id S262001AbTFDAPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:15:54 -0400
Date: Tue, 3 Jun 2003 19:29:11 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: lost interrupts with 2.4.21-rc6 and i875p chipset
Message-ID: <20030604002911.GA1379@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030603111519.GA23228@glitch.localdomain> <20030603234359.GA690@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603234359.GA690@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this occur if you build the kernel without ACPI and without APIC
> support ?

After a bit of experimenting with pre7, I found that I only need to
disable IOAPIC (ACPI was already disabled).  Thanx for the pointer!


   $ grep APIC config_glitch.apic.2
   CONFIG_X86_GOOD_APIC=y
   CONFIG_X86_UP_APIC=y
   # CONFIG_X86_UP_IOAPIC is not set
   CONFIG_X86_LOCAL_APIC=y
