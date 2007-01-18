Return-Path: <linux-kernel-owner+w=401wt.eu-S1751125AbXARVBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXARVBN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 16:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXARVBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 16:01:13 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:38663 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751125AbXARVBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 16:01:13 -0500
Date: Thu, 18 Jan 2007 22:01:10 +0100
From: Martin Mares <mj@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <matthew@wil.cx>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC] pci_bus conversion to struct device
Message-ID: <mj+md-20070118.205904.29248.nikam@ucw.cz>
References: <20070118005344.GA8391@kroah.com> <20070118022352.GA17531@parisc-linux.org> <mj+md-20070118.081204.18154.nikam@ucw.cz> <20070118090044.GA23596@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118090044.GA23596@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> So, if it were to stay, where in the tree should it be?  Hanging off of
> the pci device that is the bridge?  Or just placing these files within
> the pci device directory itself, as it is the bridge.

I originally didn't realize that we already represent devices on the
subordinate bus as subdirectories of the bridge device's directory,
without any extra level of abstraction. So it probably makes sense
to put the bus-specific files there or, in case of a root bus, to
/sys/devices/pciXXXX:YY/.

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"It is only with the heart that one can see rightly; What is essential is invisible to the eye." -- The Little Prince
