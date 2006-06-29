Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWF2DL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWF2DL5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWF2DL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:11:57 -0400
Received: from dvhart.com ([64.146.134.43]:56230 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750997AbWF2DL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:11:56 -0400
Message-ID: <44A344E6.7040200@mbligh.org>
Date: Wed, 28 Jun 2006 20:11:34 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nigel@suspend2.net
Cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       Jens Axboe <axboe@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 0/9] Extents support.
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net> <200606271858.21810.nigel@suspend2.net> <20060628211114.GC13397@elf.ucw.cz> <200606290825.50674.nigel@suspend2.net>
In-Reply-To: <200606290825.50674.nigel@suspend2.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's not true. The compression and encryption support add ~1000 lines, as 
> you pointed out the other day. If I moved compression and encryption support 
> to userspace, I'd remove 1000 lines and:
> 
> - add more code for getting the pages copied to and from userspace
> - require the user to get and build $LIBRARIES for doing the compression
> - require the user to get and build $HELPER for doing the interface to 
> Suspend2
> - fail to leverage the perfectly good cryptoapi routines that are already 
> there
> - slow the whole process down because I'd now have a copy to userspace for 
> every page being compressed/encrypted and a copy from userspace for every 
> output page.
> - make life more complicated for distro maintainers and users because they'd 
> have another set of dependencies to worry about and mess with.
> 
> I'm not saying it's impossible. I'm just saying it would make suspending more 
> complicated, at least potentially slower and more of a pain for everyone.

Thanks for actually thinking through about the implications of pushing
yet another subsystem out into userspace. Most people don't seem to
bother ;-(

M.

