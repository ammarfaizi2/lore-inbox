Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTDOVjc (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbTDOVjc 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:39:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264110AbTDOVjb 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:39:31 -0400
Date: Tue, 15 Apr 2003 14:50:05 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: Problem: 2.4.20, 2.5.66 have different IDE channel order
Message-Id: <20030415145005.20383a70.rddunlap@osdl.org>
In-Reply-To: <1050439381.28591.15.camel@dhcp22.swansea.linux.org.uk>
References: <200304151436_MC3-1-3487-2162@compuserve.com>
	<1050439381.28591.15.camel@dhcp22.swansea.linux.org.uk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr 2003 21:43:02 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

| On Maw, 2003-04-15 at 19:33, Chuck Ebbert wrote:
| >   Well, that matches what 2.4 does:
| > 
| > 
| > 00:0d.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
| > 00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
| > 01:0b.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)
| > 
| > 
| >   2.5 nonmodular seems to be doing it in BIOS order  -- the HPT370 BIOS
| > initializes before the Promise (and won't let it boot but I can deal
| > with that.)  I'll probably replace it with a PDC20262 before looking
| 
| Im a bit puzzled by this because it does look like a bug. Our pci scan code hasnt changed
| that materially. I assume the promise and hpt are both plug in cards >

but something also changed NIC interface ordering (according to davej et al)...
so maybe it's deep inside PCI bus scanning.

--
~Randy
