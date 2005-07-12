Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVGLVjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVGLVjN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVGLVg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:36:29 -0400
Received: from animx.eu.org ([216.98.75.249]:13717 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262422AbVGLVgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:36:21 -0400
Date: Tue, 12 Jul 2005 17:53:32 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-ID: <20050712215332.GA31021@animx.eu.org>
Mail-Followup-To: Helge Hafting <helge.hafting@aitel.hist.no>,
	Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
References: <20050710014559.GA15844@animx.eu.org> <E1DrRLL-00017G-00@calista.eckenfels.6bone.ka-ip.net> <20050710125438.GA17784@animx.eu.org> <42D253B5.20101@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42D253B5.20101@aitel.hist.no>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Wakko Warner wrote:
> You don't need to zero out swapfiles. You can fill them with anything,
> even /dev/urandom.  Zero-filling may be faster though.  A swapfile
> is not zero the second time you use it - then it contains leftovers
> from last time.

I understand this part.

> >So are you saying that if I create a swap partition it's best to use dd to
> >zero it out before mkswap?  If no, then why would a file be different?  I
> >know there's no documented way to create a file of given size without
> >writing content.  I saw windows grow a pagefile several meg in less than a
> >second so I'm sure that it doesn't zero out the space first.
>
> Linux doesn't grow swapfiles at all.  It uses what's there at mkswap time.
> You can make new ones of course - manually.

And this part.  I've never known linux to grow the swap file.  I did try the
sparse one a long time ago.  Of course it didn't work.

> >As far as portable, we're talking about linux, portability is not an issue
> >in this case.  I myself don't use swap files (or partitions), however, 
> >there
> >was a project I recall that would dynamically add/remove swap as needed. 
> >Creating a file of 20-50mb quickly would have been beneficial.
>
> You can create 50M quickly - even if it actually have to be written.  If
> you can't, don't use that device for swap. 

Not all systems can create 50mb in a short time.  Especially when the
system/device is under load.  Not all systems have multiple disks either.

> Ability to allocate some blocks without actually writing to them is nice 
> for this
> purpose, but current linux filesystems doesn't have an api for doing that.
> The necessary changes would touch all existing writeable filesystems, and
> that is a lot of work for very little gain.  As they say, you don't 
> create swapfiles
> all that often.  The time saved on swapfile creation might take a long 
> time to
> make up for the time spent on making, auditing and supporting those
> changes.

I hadn't considered this "portability" so I didn't understand at that
point.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
