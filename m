Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965301AbVKHDL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbVKHDL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965193AbVKHDL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:11:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:24804 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965188AbVKHDL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:11:26 -0500
Date: Mon, 7 Nov 2005 19:10:36 -0800
From: Greg KH <greg@kroah.com>
To: Neil Brown <neilb@suse.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/18] make /proc/mounts pollable
Message-ID: <20051108031036.GA1200@kroah.com>
References: <E1EZInj-0001Ej-9n@ZenIV.linux.org.uk> <17264.5467.78557.38472@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17264.5467.78557.38472@cse.unsw.edu.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 02:02:51PM +1100, Neil Brown wrote:
> 
> Ahh, now this is interesting.

Yeah, if we do this, we get rid of the "mount"-like kernel uevents, as
they were in the wrong place.

> I wonder if there is any chance of attributes in sysfs being pollable
> too??

I haven't had anyone ask for this yet.  It might be a bit harder, as we
would need to have a hook back to sysfs to let userspace know it had
changed.  As long as it was optional and didn't cause any overhead for
everyone that does not need it, I don't see why it could not be added.

All we need now is a patch :)

thanks,

greg k-h
