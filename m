Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264889AbSKJOqo>; Sun, 10 Nov 2002 09:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSKJOqo>; Sun, 10 Nov 2002 09:46:44 -0500
Received: from host194.steeleye.com ([66.206.164.34]:12555 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264889AbSKJOqn>; Sun, 10 Nov 2002 09:46:43 -0500
Message-Id: <200211101453.gAAErOb10864@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: torvalds@transmeta.com, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: BOGUS: megaraid changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2002 09:53:23 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus - will you please stop merging plain dangerous "lets pretend we
> never have errors" patches. I've got proper fixes for megaraid to use
> the new_eh if you want them, but merging stuff so that people don't
> even notice the problem is *WRONG*

This one came in through my scsi tree.  How about we fix the issue in a 
different way:  I can add an option in SCSI to check for the new eh methods 
and if it doesn't find any at all, panic the system saying that this driver 
has no error handling but if you reboot with the scsi_no_error_handling option 
it won't panic again?

James


