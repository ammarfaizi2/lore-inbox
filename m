Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTDQDwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTDQDwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:52:31 -0400
Received: from granite.he.net ([216.218.226.66]:33798 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262912AbTDQDwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:52:30 -0400
Date: Wed, 16 Apr 2003 21:06:41 -0700
From: Greg KH <greg@kroah.com>
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'David Gibson'" <david@gibson.dropbear.id.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030417040641.GD2201@kroah.com>
References: <A46BBDB345A7D5118EC90002A5072C780C262E38@orsmsx116.jf.intel.com> <20030417033154.GD31473@ranty.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030417033154.GD31473@ranty.ddts.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 05:31:54AM +0200, Manuel Estrada Sainz wrote:
> 
>  I don't know that much about sysfs, after a little investigation, it
>  seams like sysfs entries are restricted in size to PAGE_SIZE, which on
>  i386 is 4K, and ezusb firmware is already 6.9K in size.
> 
>  I would really appreciate someone more knowledgeable than myself
>  commenting on the possibility of extending sysfs to fill this gap.

Yes, I don't think this would be that tough to add.  Matthew Wilcox
posted a patch to clean up a lot of problems with the current binary
file sysfs interface, and after that patch is in the main tree, it
shouldn't be that touch to change to support these kinds of files.

Although I do like the idea and implementation of fwfs, nice job :)

Hope this helps,

greg k-h
