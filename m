Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUHHFxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUHHFxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 01:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUHHFxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 01:53:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:24045 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265152AbUHHFxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 01:53:35 -0400
Date: Sat, 7 Aug 2004 22:53:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Mares <mj@ucw.cz>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       James.Bottomley@steeleye.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <20040807114046.GA5249@ucw.cz>
Message-ID: <Pine.LNX.4.58.0408072250370.1793@ppc970.osdl.org>
References: <200408071128.i77BSNCd006957@burner.fokus.fraunhofer.de>
 <20040807114046.GA5249@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Aug 2004, Martin Mares wrote:
>
> Most of all, I would like to know (I see I'm repeating myself, but I still
> haven't seen an answer to that) what's so special about the SCSI-like devices,

Don't even bother.

Joerg is wrong. SCSI number simply doesn't work, and the current Linux 
setup is absolutely the right thing to do.

If Joerg keeps breaking cdrecord, the distributions will hopefully just 
keep unbreaking it. The way you send SCSI commands to a device under Linux 
is to open the device (with O_NDELAY) and then just start sending the 
commands. None of the idiotic scanning and SCSI numbering crap.

Involving Joerg in it just makes you go crazy. Don't bother.

		Linus
