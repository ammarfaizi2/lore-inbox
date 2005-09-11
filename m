Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbVIKLgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbVIKLgI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbVIKLgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:36:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41869 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932504AbVIKLgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:36:06 -0400
Date: Sun, 11 Sep 2005 13:33:56 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "John W. Linville" <linville@tuxdriver.com>, Greg KH <gregkh@suse.de>,
       davej@codemonkey.org.uk, arjan@infradead.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050911113356.GB2742@elf.ucw.cz>
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org> <20050909225421.GA31433@suse.de> <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org> <20050910183302.GA6311@tuxdriver.com> <Pine.LNX.4.58.0509101152430.30958@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509101152430.30958@g5.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But, aren't these arguments for changing the functions to return void?
> > If there is never any point in checking the results, then why have
> > results at all?
> 
> Trying to set other power states than D0 might return interesting values. 
> Also, you _can_ use the value to determine whether the device supports PM 
> states at all.

Perhaps we should make pci_set_power_state(pdev, PCI_D0) to succeed in
case of old device not supporting power managment? As you've said, it
is effectively in PCI_D0 anyway ;-).
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
