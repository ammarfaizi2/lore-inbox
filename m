Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbVKWVjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbVKWVjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbVKWVjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:39:31 -0500
Received: from mail.dvmed.net ([216.237.124.58]:58245 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932545AbVKWVj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:39:29 -0500
Message-ID: <4384E184.3040304@pobox.com>
Date: Wed, 23 Nov 2005 16:39:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
References: <437D2DED.5030602@pobox.com> <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de> <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
In-Reply-To: <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Bogdan Costescu wrote: > On Fri, 18 Nov 2005, Jeff
	Garzik wrote: > >> Yes, for both 50xx and 60xx, I had to turn off MSI
	in order to get >> sata_mv to work... > > > With MSI and libata DEBUG
	turned off I had a crash - solid one, SysRQ > doesn't work. I have
	forgotten to set console to serial port when > booting this kernel, so
	what follows is what I had on the screen, > hopefully without any typos
	(and without the initial addresses): [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> On Fri, 18 Nov 2005, Jeff Garzik wrote:
> 
>> Yes, for both 50xx and 60xx, I had to turn off MSI in order to get
>> sata_mv to work...
> 
> 
> With MSI and libata DEBUG turned off I had a crash - solid one, SysRQ 
> doesn't work. I have forgotten to set console to serial port when 
> booting this kernel, so what follows is what I had on the screen, 
> hopefully without any typos (and without the initial addresses):

I wonder if the global reset disables MSI...  may be a driver bug.

You could play around with moving the pci_enable_msi until after the 
global reset...

	Jeff



