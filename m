Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWB0Wmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWB0Wmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWB0Wml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:42:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38789 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932355AbWB0WmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:42:22 -0500
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
Date: Mon, 27 Feb 2006 23:42:09 +0100
User-Agent: KMail/1.9.1
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
References: <44028502.4000108@soft.fujitsu.com> <20060227214244.GA9008@colo.lackof.org> <44037BC6.30003@pobox.com>
In-Reply-To: <44037BC6.30003@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602272342.11047.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 February 2006 23:23, Jeff Garzik wrote:
> Or do you have another way of avoiding unused resource allocation?
> 
> Fix the [firmware | device load order] to allocate I/O ports first to 
> the hardware that only supports IO port accesses. 

How should the firmware know what hardware needs io ports and what hardware
doesn't? I don't think it will scale well to put long lists of PCI-IDs into 
their firmware.

The driver is really the natural place to put such knowledge.

-Andi

