Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUC3G74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbUC3G74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:59:56 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:35737 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263125AbUC3G7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:59:54 -0500
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if
	non-modular IDE
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2004.03.29.21.34.45.973137@dungeon.inka.de>
References: <200403282136.55435.arekm@pld-linux.org>
	 <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
	 <1080517591.5047.10.camel@laptop-linux.wpcb.org.au>
	 <pan.2004.03.29.21.34.45.973137@dungeon.inka.de>
Content-Type: text/plain
Message-Id: <1080629551.12019.12.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk 
Date: Tue, 30 Mar 2004 16:52:31 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-03-30 at 07:34, Andreas Jellinghaus wrote:
> so suspend to disk does not work with scsi?
> 
> >> > -       depends on PM && SWAP
> >> > +       depends on PM && SWAP && IDE=y && BLK_DEV_IDEDISK=y
> 
> implies IDE is needed.

It is at the moment, I'm afraid. I'm hoping to get SCSI support for
suspend2 finished shortly. I did suspend a OSDL machine to SCSI in
January, but the driver lacked the power management that I needed to
reload the second half of the image and thereby be sure all was okay.

> btw: would it be somehow possible to resume after initrd phase?
> or some other idea how a generic kernel with modules in the initrd
> could use suspend to disk? or a laptop where the initrd is needed
> to setup a dm-crypt volume with the right decrypton key?

That should be doable, provided that the initrd doesn't mount anything.
Decryption is 'interesting'. The key needs to be set up in the resumed
kernel too. (Shouldn't be a problem, if you manage to suspend to it!).

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

