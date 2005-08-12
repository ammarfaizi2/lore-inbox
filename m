Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVHLL3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVHLL3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 07:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbVHLL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 07:29:44 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52933 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750999AbVHLL3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 07:29:43 -0400
Date: Fri, 12 Aug 2005 13:29:35 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Need help in understanding x86 syscall
In-Reply-To: <Pine.LNX.4.61.0508111430280.19138@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0508121325330.2499@be1.lrz>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> 
 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> 
 <1123770661.17269.59.camel@localhost.localdomain>  <2cd57c90050811081374d7c4ef@mail.gmail.com>
  <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com> 
 <1123775508.17269.64.camel@localhost.localdomain> 
 <1123777184.17269.67.camel@localhost.localdomain>  <2cd57c90050811093112a57982@mail.gmail.com>
  <2cd57c9005081109597b18cc54@mail.gmail.com>  <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
  <1123781187.17269.77.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0508111342170.15330@chaos.analogic.com>
 <1123783862.17269.89.camel@localhost.localdomain>
 <Pine.LNX.4.61.0508111430280.19138@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Zwane Mwaikambo wrote:
> On Thu, 11 Aug 2005, Steven Rostedt wrote:
> > On Thu, 2005-08-11 at 13:46 -0400, linux-os (Dick Johnson) wrote:

> > int is a call to either an interrupt or exception procedure. 0x80 is
> > setup in Linux to be a trap and not an interrupt vector. So it does
> > _not_ turn off interrupts.
> 
> It's actually a vector, that's all you can install in the IDT.

It's a vector + metadata, most noticably a privilege level and a
descriptor type.

http://www.acm.uiuc.edu/sigops/roll_your_own/i386/idt.html

-- 
Top 100 things you don't want the sysadmin to say:
47. Say, What does "Superblock Error" mean, anyhow?
