Return-Path: <linux-kernel-owner+w=401wt.eu-S1752023AbXARIOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbXARIOJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 03:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXARIOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 03:14:09 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:55381 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752023AbXARIOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 03:14:08 -0500
Date: Thu, 18 Jan 2007 09:14:06 +0100
From: Martin Mares <mj@ucw.cz>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] pci_bus conversion to struct device
Message-ID: <mj+md-20070118.081204.18154.nikam@ucw.cz>
References: <20070118005344.GA8391@kroah.com> <20070118022352.GA17531@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118022352.GA17531@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I recommend we just delete the pci_bus class.  I don't think it serves
> any useful purpose.  The bridge can be inferred frmo the sysfs hierarchy
> (not to mention lspci will tell you).  The cpuaffinity file should be
> moved from the bus to the device -- it really doesn't make any sense to
> talk about which cpu a bus is affine to, only a device.

It doesn't seem to serve any useful purpose other than the affinity now,
but I still think that it conceptually belongs there, because it makes
sense to have per-bus attributes. For example, in the future we could
show data width and signalling speed.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"I invented the term Object-Oriented, and I can tell you I did not have C++ in mind." -- Alan Kay
