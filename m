Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUFEPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUFEPhe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 11:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUFEPhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 11:37:33 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:31909 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261610AbUFEPhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 11:37:32 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: sboyce@blueyonder.co.uk
Subject: Re: 2.6.7-rc2-mm1 (nforce2 lockup)
Date: Sat, 5 Jun 2004 09:37:29 -0600
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FD33E@hdsmsx403.hd.intel.com> <1086385540.2241.322.camel@dhcppc4> <40C1455E.30501@blueyonder.co.uk>
In-Reply-To: <40C1455E.30501@blueyonder.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406050937.29163.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 10:00 pm, Sid Boyce wrote:
> I just built and successfully booted 2.6.7-rc2-mm2 IOAPIC enabled and 
> without boot option acpi=off. I guess somewhere IOAPIC was inadvertently 
> disabled in .config.

So I guess IOAPIC was enabled in your pre-mm1 builds that worked?

I just want to make sure my patch doesn't add a requirement for
IOAPIC where it wasn't required before.

My assumption is that
	- 2.6.7-rc2 without IOAPIC fails (I'm not sure you've tried
		this; I don't think I've seen a report either way)
	- 2.6.7-rc2 with IOAPIC works
	- 2.6.7-rc2-mm2 without IOAPIC fails
	- 2.6.7-rc2-mm2 with IOAPIC works
