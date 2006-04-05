Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWDEWdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWDEWdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbWDEWdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:33:23 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:20135 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932095AbWDEWdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:33:22 -0400
Date: Wed, 05 Apr 2006 18:33:21 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [PATCH] modules_install must not remove existing modules
In-reply-to: <200604052152.k35LqtQ0032100@turing-police.cc.vt.edu>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200604051833.21561.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200604052333.51085.agruen@suse.de>
 <200604052152.k35LqtQ0032100@turing-police.cc.vt.edu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 17:52, Valdis.Kletnieks@vt.edu wrote:
>On Wed, 05 Apr 2006 23:33:50 +0200, Andreas Gruenbacher said:
>> When installing external modules with `make modules_install', the
>> first thing that happens is a rm -rf of the target directory. This
>> works only once, and breaks when installing more than one (set of)
>> external module(s).
>
>Can this be re-worked to ensure that it clears the target directory
>the *first* time?  It would suck mightily if a previous build of
> 2.6.17-rc2 left a net_foo.ko lying around to get insmod'ed by
> accident (consider the case of CONFIG_NETFOO=m getting changed to y
> or n, and other possible horkage. Module versioning will catch some,
> but not all, of this crap....)

I avoid this in my own makeit script by mv'ing all that stuff to 
a /lib/modules/version_number.old, ditto for vmlinuz and initrd.  That 
way, if the new one doesn't work, I can choose some other kernel in the 
grub startup, boot it it, then just mv the stuff back, and voila!  
Another reboot and I'm back on the last kernel that worked.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
