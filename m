Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVIJSy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVIJSy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 14:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVIJSy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 14:54:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932206AbVIJSy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 14:54:27 -0400
Date: Sat, 10 Sep 2005 11:53:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "John W. Linville" <linville@tuxdriver.com>
cc: Greg KH <gregkh@suse.de>, davej@codemonkey.org.uk, arjan@infradead.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <20050910183302.GA6311@tuxdriver.com>
Message-ID: <Pine.LNX.4.58.0509101152430.30958@g5.osdl.org>
References: <20050909220758.GA29746@kroah.com> <Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
 <20050909225421.GA31433@suse.de> <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
 <20050910183302.GA6311@tuxdriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, John W. Linville wrote:
> 
> But, aren't these arguments for changing the functions to return void?
> If there is never any point in checking the results, then why have
> results at all?

Trying to set other power states than D0 might return interesting values. 
Also, you _can_ use the value to determine whether the device supports PM 
states at all.

There are tons of functions that return values. That doesn't mean that you 
always have to check them.

		Linus
