Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbUJ1RRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbUJ1RRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbUJ1RRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:17:40 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:43707 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262530AbUJ1ROs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:14:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: James Morris <jmorris@redhat.com>
Subject: Re: Fw: Re: 2.6.10-rc1-mm1
Date: Thu, 28 Oct 2004 11:14:39 -0600
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@intel.com
References: <Xine.LNX.4.44.0410280225110.13421-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0410280225110.13421-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410281114.39861.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 12:25 am, James Morris wrote:
> On Wed, 27 Oct 2004, Bjorn Helgaas wrote:
> > I did find a couple places that unregister the driver even when
> > acpi_bus_register_driver() fails, which could cause this.  But I
> > really doubt that this is the problem, because the only error
> > returns there are for "acpi_disabled" and "!driver".  Patch is
> > attached anyway if you want to try it.
> 
> This looks to have fixed the problem.

Hmmm.  Can you add a little more debug (i.e., the printk in
acpi_bus_unregister_driver(), and some in the acpi_bus_register_driver()
failure paths)?  I really don't understand how that patch could
have fixed the problem, and I hate to paper over a problem without
understanding it better.
