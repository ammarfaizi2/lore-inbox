Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266488AbUITNTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266488AbUITNTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUITNTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:19:32 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:13696 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S266488AbUITNTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:19:30 -0400
Date: Mon, 20 Sep 2004 23:19:10 +1000
From: CaT <cat@zip.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920131910.GB1096@zip.com.au>
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <Pine.LNX.4.61.0409201220200.3460@scrub.home> <20040920105618.GB24928@suse.de> <Pine.LNX.4.61.0409201311050.3460@scrub.home> <20040920112607.GA19073@suse.de> <Pine.LNX.4.61.0409201331320.3460@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0409201331320.3460@scrub.home>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 01:38:44PM +0200, Roman Zippel wrote:
> > What do you mean by auto vs. manual? I dont understand what you mean
> > here.
> 
> $ mount -oloop image /mnt
> 
> vs
> 
> $ losetup image /dev/loop0
> $ mount /dev/loop0 /mnt
> 
> What should umount do, when called with /mnt?

Does the kernel crash and burn if you pass the filesystem an option it
does not know about on a mount? If not then just have mount pass all
the options it gets to the kernel, the fs weeds out what it likes and 
the full thing gets stored for use in /proc/self/mounts.

That would mean the above would have loop stored for the first and
not for the second and so umount would know what to do with each
case.

(from another bit of this thread) This would also mean that the user
keyword can be stored too.

-- 
    Red herrings strewn hither and yon.
