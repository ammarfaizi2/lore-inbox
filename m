Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbTELRVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 13:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTELRU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 13:20:58 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:34977 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262328AbTELRUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 13:20:55 -0400
Date: Mon, 12 May 2003 18:34:04 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.net
Subject: Re: [PATCH] better ali1563 integrated ethernet support
Message-ID: <20030512173404.GA11936@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.net
References: <200305111914.h4BJES3g007061@hera.kernel.org> <20030512113038.GA31870@suse.de> <Pine.LNX.4.53.0305121029330.21172@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305121029330.21172@twinlark.arctic.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:31:44AM -0700, dean gaudet wrote:
 > >  >  #if defined(__sparc__)
 > >  >          /* DM9102A needs 32-dword alignment/burst length on sparc - chip bug? */
 > >  > -        if (pdev->vendor == 0x1282 && pdev->device == 0x9102)
 > >  > +	if ((pdev->vendor == 0x1282 && pdev->device == 0x9102)
 > >  > +		|| (pdev->vendor == 0x10b9 && pdev->device == 0x5261))
 > >  >                  csr0 = (csr0 & ~0xff00) | 0xe000;
 > >  >  #endif
 > >
 > > Integrated ALi 1563 on a sparc ?
 > 
 > oh duh i didn't even look hard at that... i just went and made sure any
 > 9102 bug tests were copied, in case the ali1563 was a bug-for-bug clone :)
 > 1563 is a hypertransport device... so i doubt it'll show up on a sparc.
 > oops.

For completeness, we should probably remove the entry from the dmfe
pci_device_id table too.

		Dave

