Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423782AbWKFK0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423782AbWKFK0p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423778AbWKFK0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:26:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52633 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423782AbWKFK0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:26:44 -0500
Subject: Re: could not find filesystem /dev/root
From: Arjan van de Ven <arjan@infradead.org>
To: Mathieu SEGAUD <matt@regala.cx>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <873b8wubcc.fsf@barad-dur.regala.cx>
References: <454E95E1.2010708@perkel.com>
	 <873b8wubcc.fsf@barad-dur.regala.cx>
Content-Type: text/plain; charset=UTF-8
Organization: Intel International BV
Date: Mon, 06 Nov 2006 11:26:39 +0100
Message-Id: <1162808799.3160.197.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 11:18 +0100, Mathieu SEGAUD wrote:
> Vous m'avez dit récemment :
> 
> > Trying to compile a new kernel and getting this on boot
> >
> > could not find filesystem /dev/root
> 
> sure it doesn't spit only this to you. Does it panic ? and do FC6
> kernels use an initrd (I guess so) ?

they do and it's more or less required there (for mount-by-label and
many other things).

But it's easy to do.
In fact, if you use "make install" as the last step in your build
process, the kernel build process will
1) copy the bzImage over to /boot for you
2) make an initrd for your system
3) add the kernel and initrd to grub for you

this is a very convenient step that makes it very robust to do, and
beats doing the manual thing even if you wouldn't do an initrd in terms
of convenience..

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

