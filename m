Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVGPNye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVGPNye (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGPNwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:52:03 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:30187 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261608AbVGPNvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:51:36 -0400
Date: Fri, 15 Jul 2005 10:35:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Stefan Seyfried <seife@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: resuming swsusp twice
Message-ID: <20050715083537.GB1772@elf.ucw.cz>
References: <20050713185955.GB12668@hexapodia.org> <42D67D84.2020306@suse.de> <20050714175447.GA16651@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050714175447.GA16651@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I of course won't say that this cannot happen, but by design, the
> > swsusp
> > signature is invalidated even before reading the image, so
> > theoretically
> > it should not happen.
> 
> Yes, I'd seen that happen on earlier swsusps, so I was quite suprised
> when it blew up like this.
> 
> Perhaps the image should be more rigorously checked?  I'm wishing that
> it would verify that the header and the image matched, after it finishes
> reading the image.  For example, computing the hash
> 
> MD5(header || image)     (|| denotes "concatenate" in crypto pseudocode.)
> 
> and storing that hash in a final trailing block.  Additionally, of
> course, as soon as the resume has read the image it should overwrite the
> header; and the header should include jiffies or something along those
> lines to ensure that it won't accidentally have the same contents as the
> previous image's header.
> 
> The hash doesn't have to be MD5; even a CRC should suffice I think...

That's quite a lot of complexity... just fix the bug.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
