Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVIJSdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVIJSdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVIJSdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:33:54 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:59403 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932138AbVIJSdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:33:54 -0400
Date: Sat, 10 Sep 2005 14:33:04 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, davej@codemonkey.org.uk, arjan@infradead.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050910183302.GA6311@tuxdriver.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Greg KH <gregkh@suse.de>, davej@codemonkey.org.uk,
	arjan@infradead.org, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org> <20050909225421.GA31433@suse.de> <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 04:22:25PM -0700, Linus Torvalds wrote:

> the return value of "pci_enable_wake()" for example. There's really no
> real reason to ever care, as far as I can tell - if it fails, there's 
> nothing you can really do about it anyway.
> 
> Also, in general, the fact is that things like "pci_set_power_state()" 
> might fail in _theory_, but we just don't care. A driver that doesn't 

But, aren't these arguments for changing the functions to return void?
If there is never any point in checking the results, then why have
results at all?

John
-- 
John W. Linville
linville@tuxdriver.com
