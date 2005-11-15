Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVKOW0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVKOW0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVKOW0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:26:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40648 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965049AbVKOW0K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:26:10 -0500
Date: Tue, 15 Nov 2005 17:25:49 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051115222549.GF17023@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051115212942.GA9828@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:29:42PM +0100, Pavel Machek wrote:
 > Hi!
 > 
 > This is prototype of userland swsusp. I'd like kernel parts to go in,
 > probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
 > slightly ugly, OTOH it would be probably overkill to introduce
 > syscalls just for this. (I'll need to add an ioctl for freeing memory
 > in future).

Just for info: If this goes in, Red Hat/Fedora kernels will fork
swsusp development, as this method just will not work there.
(We have a restricted /dev/mem that prevents writes to arbitary
 memory regions, as part of a patchset to prevent rootkits)

Even it were not for this, the whole idea seems misconcieved to me
anyway.

		Dave

