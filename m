Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265974AbSKDHH7>; Mon, 4 Nov 2002 02:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265977AbSKDHH6>; Mon, 4 Nov 2002 02:07:58 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:700 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265974AbSKDHHK> convert rfc822-to-8bit; Mon, 4 Nov 2002 02:07:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: dcinege@psychosis.com, andersen@codepoet.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
Date: Mon, 4 Nov 2002 02:13:20 +0000
User-Agent: KMail/1.4.3
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <200210272017.56147.landley@trommello.org> <20021030085149.GA7919@codepoet.org> <200210300455.21691.dcinege@psychosis.com>
In-Reply-To: <200210300455.21691.dcinege@psychosis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211011917.16978.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 October 2002 09:55, Dave Cinege wrote:

> But not from userland. Tar is used en masse, cpio isn't.

Red hat uses cpio all over the place.  RPM is cpio based, and the drivers in a 
Red Hat boot disk or driver disk are in a cpio file as well (and their cdrom 
boot process uses the same code, so that's also cpio).  This almost certainly 
means Mandrake uses the same stuff, and between the two of them we are over 
50% of both the Linux installed base, new sales, and new installs.  (Take 
your pick of what you want to measure.)

Yeah, cpio is a pain and change to use, but so is tar.  You're just used to 
it.  To get the behavior you want creating a tarball, your option list is 
probably something like "tar cvjfpC tarball.tbz dirname .".  Hands up 
everybody who thinks cvjfpC is intuitive?  Yes you could instead do "cd 
dirname; tar cvp * | bzip2 > tarball.tbz" if that strikes you as more 
newbie-friendly.  (This is assuming you know that that "v" goes to stderr 
rather than standard out when it detects that stdout has been redirected, but 
then you had to know to use "." rather than "*" for obvious reasons. :)

And of course this is assuming you're using gnu tar (which still doesn't 
officially support bzip by the way, j support was a patch last I checked).  
The older versions wanted a dash before the options list.  (Try the version 
of tar in busybox sometime...)

> It's the only reason to use tar over cpio...I feel it's a
> good one.

By that logic, people should stick with windows. :)

The objection is "people shouldn't have to learn a new tool when upgrading to 
a new kernel".  A tool that has been around since the 1970's, I'm might 
add...

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?



