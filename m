Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVLRRsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVLRRsO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbVLRRsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:48:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51598 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965238AbVLRRsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:48:13 -0500
Date: Sun, 18 Dec 2005 18:47:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: documentation fixes
Message-ID: <20051218174752.GB9679@elf.ucw.cz>
References: <20051216105852.GJ8476@elf.ucw.cz> <20051216183523.GF2821@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216183523.GF2821@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > +Q: How can RH ship a swsusp-supporting kernel with modular SATA
>  > +drivers?
>  >  
>  > +A: Well, it can be done, load the drivers, then do echo into resume
>  > +file from initrd. Be sure not to mount anything, not even read-only
>  > +mount, or you are going to loose your filesystem same way Dave Jones
>  > +did.
> 
> I don't need the fame here thanks.
> I've hit a thousand other ways to corrupt my rootfs, I don't think
> it's worth documenting them.  It's arguable this whole item is needed
> to be documented, but if you feel compelled to write Red Hat specific
> documentation in the swsusp docs, feel free to note that
> 'make modules_install ; make install' just does the right thing,
> including building an initrd for you with all the right pieces.

Sorry... This entry was originally real question from akpm, and I did
reply for him. I should have rewritten in when I decided to put it
into FAQ.

This should be better:

Q: How can distributions ship a swsusp-supporting kernel with modular
disk drivers (especially SATA)?

A: Well, it can be done, load the drivers, then do echo into
/sys/power/disk/resume file from initrd. Be sure not to mount
anything, not even read-only mount, or you are going to loose your
data.
								Pavel

-- 
Thanks, Sharp!
