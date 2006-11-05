Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWKEOGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWKEOGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 09:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbWKEOGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 09:06:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13780 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932690AbWKEOGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 09:06:43 -0500
Subject: Re: Scsi cdrom naming confusion; sr or scd?
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr>
References: <20061105100926.GA2883@pelagius.h-e-r-e-s-y.com>
	 <Pine.LNX.4.61.0611051232580.12727@yvahk01.tjqt.qr>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 05 Nov 2006 15:06:39 +0100
Message-Id: <1162735599.3160.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 12:33 +0100, Jan Engelhardt wrote:
> > "The prefix /dev/sr (instead of /dev/scd) has been deprecated"
> >
> >but booting 2.6.18.2 from a scsi CD only works if I pass the kernel
> >parameter root=/dev/sr0 and fails with root=/dev/scd0
> >
> >I guess the kernel ought to be taught about the scd* names aswell?
> 
> brw-r-----  1 root disk 11, 0 Mar 19  2005 /dev/scd0
> brw-r-----  1 root disk 11, 0 Mar 19  2005 /dev/sr0
> 
> Plus I see sr0 being far more commonly used than scd0.
> So I guess the doc is wrong.


and this is why it's wrong to make naming policy a kernel thing!
Userspace is the right place to do this (and there I suspect the name
will end up being /dev/cdrom)...... the kernel really shouldn't care at
all what the name is.
(I know for root= it currently has to if you don't have an initrd but..
well... that's sort of a nasty interface anyway; what if you have a usb
cdrom drive connected for example.. suddenly all your names changed)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

