Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTLCRfH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263506AbTLCRfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:35:07 -0500
Received: from aun.it.uu.se ([130.238.12.36]:1535 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263173AbTLCRfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:35:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.7873.926144.428159@alkaid.it.uu.se>
Date: Wed, 3 Dec 2003 18:34:57 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: David Balazic <david.balazic@hermes.si>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in linux-2.6.0-test11/README
In-Reply-To: <600B91D5E4B8D211A58C00902724252C01BC046D@piramida.hermes.si>
References: <600B91D5E4B8D211A58C00902724252C01BC046D@piramida.hermes.si>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic writes:
 > 2.6.0-test11/README says :
 > 
 >  If you want
 >    to make a boot disk (without root filesystem or LILO), insert a floppy
 >    in your A: drive, and do a "make bzdisk".
 > 
 > Wasn't that feature (booting without LILO or other boot loader ) removed ?
 > At least http://www.kniggit.net/wwol26.html says so.

Yes, but 'make bzdisk' was reimplemented to use a proper bootloader:
syslinux. You'll need mtools and syslinux-2.06 or later.

I'm also using this approach with 2.4 kernels now, since it eliminates
the annoying kernel size limitation of the old built-in loader.

 >    For some, this is on a floppy disk, in which case you can copy the
 >    kernel bzImage file to /dev/fd0 to make a bootable floppy.

Straight copy won't work any more, that's a README bug.
