Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVBPFyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVBPFyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVBPFyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:54:49 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:30542 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261997AbVBPFyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:54:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GL9UcSBoO8CkeaBuQQQPXeEvCZz+4SYRGZ0mBMm5Qqy3KhDNKSzC0sBuriqCvhmV1asK6+QMUhBj0xic0IecngI92Gfx0BEGqZQz3GkNoB/6sDZw8gVcz7Thwc5jaE8vq4U7k+YXrYatOd3TKGFE8e3kJiLOBH4ajrQ+h8987bM=
Message-ID: <e796392205021521541da7ee25@mail.gmail.com>
Date: Wed, 16 Feb 2005 06:54:47 +0100
From: Stefan Schweizer <sschweizer@gmail.com>
Reply-To: Stefan Schweizer <sschweizer@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] Call for help: list of machines with working S3
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050214211105.GA12808@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Model                           hack (or "how to do it")
------------------------------------------------------------------------------
Acer Aspire 1406LC          ole's radeonfb patch

I have to turn off dri, and then it works with the radeonfb patch. I
use this method because I like the fancy framebuffersplash on booting
.. although I do not reboot often when S3 wors ;)

You can find the patch here:
http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2

or for older kernels:
http://dev.gentoo.org/~genstef/files/radeon-s3-resume-2.6.10.patch

The problems with this patch are:
- you need to press a key to come back from the "resume-console" after resume.
- DRI in X does not work (at least for me with intel-agp, others
reportet it works)
I just disabloed it by not loading intel-agp (hotplug-blacklist)

I have not only issues with video not coming back, but I also need to
append acpi=noirq to my command-line that I am able to finish resuming
and use my devices correctly afterwards.

Regards,
Stefan
