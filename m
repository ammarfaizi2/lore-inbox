Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291289AbSBMBq5>; Tue, 12 Feb 2002 20:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291290AbSBMBqs>; Tue, 12 Feb 2002 20:46:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33796 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291289AbSBMBqd>; Tue, 12 Feb 2002 20:46:33 -0500
Subject: Re: 2.4.x ram issues?
To: ace@credit.com (Eugene Chupkin)
Date: Wed, 13 Feb 2002 02:00:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, tmeagher@credit.com
In-Reply-To: <Pine.LNX.4.10.10202121726530.683-100000@mail.credit.com> from "Eugene Chupkin" at Feb 12, 2002 05:40:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aoic-0003of-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a problem with high ram support on 2.4.7 to 2.4.17 all behave the
> same. I have a quad Xeon 700 box with 16gb of ram on an Intel SKA4 board.
> The ram is all the same 16 1gb PC100 SDRAM modules from Crucial. If I
> compile the kernel with high ram (64gb) support, my system runs very slow,
> it takes about 15 minutes for make menuconfig to come up. If I  recompile
> the kernel with 4gb support, it runs perfectly normal and very fast, but I
> have 12 gigs that I can't use. Is this a known issue? Is there a fix? I
> tried just about everything and I am all out of options. Please help!

Thats almost certainly indicating that the memory type range registers
were not set up correcly by the BIOS. Check /proc/mtrr and also ask your
vendor about BIOS updates to address the problem

(If there aren't any you can hack around it but its not nice to let vendors
 get away with bugs if that indeed is what it is)
