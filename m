Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbTAVQf7>; Wed, 22 Jan 2003 11:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTAVQf7>; Wed, 22 Jan 2003 11:35:59 -0500
Received: from host194.steeleye.com ([66.206.164.34]:5394 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S261742AbTAVQf6>; Wed, 22 Jan 2003 11:35:58 -0500
Message-Id: <200301221644.h0MGion18794@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andries.Brouwer@cwi.nl
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: 3c509.c 
In-Reply-To: Message from Andries.Brouwer@cwi.nl 
   of "Wed, 22 Jan 2003 02:11:26 +0100." <UTC200301220111.h0M1BQg03940.aeb@smtp.cwi.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Jan 2003 11:44:50 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl said:
> Yes, you are right. But. (I do not have an MCA machine myself, this
> was just from source inspection. Let me grep a bit more.)

> Suppose CONFIG_MCA_LEGACY is not set, and CONFIG_MCA is set. Then, as
> you say, <linux/mca-legacy.h> is not included. 

Yes, and unfortunately it does this by default.  The idea of CONFIG_MCA_LEGACY 
was to have legacy drivers unable to compile like this.  However, it seems 
that most people who will be trying this don't get the CONFIG_MCA_LEGACY set.

When the option was added, I couldn't come up with a useful scheme to make the 
legacy (which is almost all MCA drivers) require CONFIG_MCA_LEGACY (there's a 
kernel bug about this too).

However, looking through the source, the 3c509 driver is broken anyway for MCA 
(done by the eisa sysfs patches), so I think I can probably just add the extra 
pieces to convert it to the new sysfs MCA API.

James


