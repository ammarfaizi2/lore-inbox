Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbWEYXw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbWEYXw5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWEYXw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:52:57 -0400
Received: from mga03.intel.com ([143.182.124.21]:51863 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965201AbWEYXw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:52:56 -0400
X-IronPort-AV: i="4.05,174,1146466800"; 
   d="scan'208"; a="41762169:sNHT17200820"
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060525221744.GA1671@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com>
	 <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz>
	 <20060525221744.GA1671@elf.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 25 May 2006 17:04:18 -0700
Message-Id: <1148601858.3070.62.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 25 May 2006 23:52:54.0950 (UTC) FILETIME=[57758460:01C68056]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-26 at 00:17 +0200, Pavel Machek wrote:
> On Pá 26-05-06 00:12:22, Pavel Machek wrote:
> > Hi!
> > 
> > > > Does the panic go away with CONFIG_ACPI_DOCK=n?
> > 
> > > Can either Pavel or Andreas please try this little debugging patch and
> > > send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL option
> > > in your .config as well so that I can get additional info.
> > 
> > Yep, you were right... this debugging patch helps.
> 
> ...and docking +/- works, but it does not look like PCI in docking
> station is properly connected:
> 

No, I would not expect PCI to work properly with the debug patch -
basically all I did was prevent the oops and confirm that this is the
issue, I did not actually solve the problem.

I need some way to prevent acpiphp from loading before dock is completed
it's init.

I guess I will think about this some more.

Kristen
